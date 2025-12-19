import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'cache.dart';
import 'retry.dart';
import 'models/card.dart';
import 'models/card_archetype.dart';
import 'models/card_set_info.dart';
import 'models/card_set_list_item.dart';
import 'models/cardinfo_response.dart';
import 'models/check_db_version.dart';
import 'models/query.dart';
import 'models/ygoprodeck_error.dart';

/// Client for the YGOPRODeck Yu-Gi-Oh! API (v7).
class YgoProDeckClient {
  /// Create a client with optional caching and logging.
  ///
  /// Provide [cacheStore] to enable offline-first caching. Use [cacheMode]
  /// to force refresh or offline-only behavior. Enable [verboseLogging] to
  /// log query params and response summaries.
  YgoProDeckClient({
    http.Client? httpClient,
    Logger? logger,
    bool showDebugLogs = false,
    Uri? baseUri,
    CacheStore? cacheStore,
    CachePolicy? cachePolicy,
    CacheMode cacheMode = CacheMode.normal,
    bool allowStaleOnError = true,
    bool enableCaching = true,
    RateLimiter? rateLimiter,
    RetryPolicy? retryPolicy,
    bool verboseLogging = false,
  })  : _httpClient = httpClient ?? http.Client(),
        _ownsClient = httpClient == null,
        _showDebugLogs = showDebugLogs,
        _logger = logger ??
            (showDebugLogs
                ? Logger(
                    printer: PrettyPrinter(
                      methodCount: 0,
                      noBoxingByDefault: true,
                      printEmojis: false,
                    ),
                  )
                : null),
        _baseUri = baseUri ?? Uri.parse('https://db.ygoprodeck.com/api/v7/'),
        _cacheStore = enableCaching
            ? (cacheStore ?? MemoryCacheStore())
            : null,
        _cachePolicy = cachePolicy ?? CachePolicy.defaultPolicy(),
        _cacheMode = cacheMode,
        _allowStaleOnError = allowStaleOnError,
        _rateLimiter = rateLimiter ?? RateLimiter.perSecond(20),
        _retryPolicy = retryPolicy ?? RetryPolicy(),
        _verboseLogging = verboseLogging;

  final http.Client _httpClient;
  final bool _ownsClient;
  final bool _showDebugLogs;
  final Logger? _logger;
  final Uri _baseUri;
  final CacheStore? _cacheStore;
  final CachePolicy _cachePolicy;
  final CacheMode _cacheMode;
  final bool _allowStaleOnError;
  final RateLimiter _rateLimiter;
  final RetryPolicy _retryPolicy;
  final bool _verboseLogging;

  /// Fetch card information using optional filters.
  ///
  /// Passing a null [query] returns all cards, which is a large response.
  Future<CardInfoResponse> getCards({CardInfoQuery? query}) async {
    if (query != null &&
        query.name?.isNotEmpty == true &&
        query.id?.isNotEmpty == true) {
      throw ArgumentError(
        'YGOPRODeck API does not allow using name and id together.',
      );
    }
    final params = query?.toQueryParameters() ?? <String, String>{};
    if (_verboseLogging && params.isNotEmpty) {
      _logDebug('Query params: $params');
    }
    final uri = _endpoint('cardinfo.php', params.isEmpty ? null : params);
    final json = await _getJson(uri);
    return CardInfoResponse.fromJson(json as Map<String, dynamic>);
  }

  /// Fetch a random card.
  Future<Card> getRandomCard() async {
    final uri = _endpoint('randomcard.php', null);
    final sanitized = _stripQuery(uri);
    try {
      final json = await _getJson(sanitized);
      return Card.fromJson(json as Map<String, dynamic>);
    } on YgoProDeckApiException catch (e) {
      if (_isRandomParamsError(e)) {
        return _getRandomCardViaCardInfo();
      }
      rethrow;
    } on Exception {
      if (_cacheMode == CacheMode.offlineOnly) {
        rethrow;
      }
      return _getRandomCardViaCardInfo();
    }
  }

  /// Fetch all card sets.
  Future<List<CardSetListItem>> getCardSets() async {
    final uri = _endpoint('cardsets.php', null);
    final json = await _getJson(uri);
    return (json as List<dynamic>)
        .map((item) =>
            CardSetListItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Fetch card set details by set code.
  Future<List<CardSetInfo>> getCardSetInfo({required String setCode}) async {
    final uri = _endpoint('cardsetsinfo.php', {'setcode': setCode});
    final json = await _getJson(uri);
    return (json as List<dynamic>)
        .map((item) => CardSetInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Fetch all archetypes.
  Future<List<CardArchetype>> getArchetypes() async {
    final uri = _endpoint('archetypes.php', null);
    final json = await _getJson(uri);
    return (json as List<dynamic>)
        .map((item) => CardArchetype.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Check the database version.
  Future<CheckDbVersion> checkDbVersion() async {
    final uri = _endpoint('checkDBVer.php', null);
    final json = await _getJson(uri);
    if (json is List && json.isNotEmpty) {
      return CheckDbVersion.fromJson(json.first as Map<String, dynamic>);
    }
    return CheckDbVersion.fromJson(json as Map<String, dynamic>);
  }

  /// Release underlying HTTP resources.
  void close() {
    if (_ownsClient) {
      _httpClient.close();
    }
  }

  Uri _endpoint(String path, Map<String, String>? queryParameters) {
    final resolved = _baseUri.resolve(path);
    if (queryParameters == null || queryParameters.isEmpty) {
      return resolved;
    }
    return resolved.replace(queryParameters: queryParameters);
  }

  Future<dynamic> _getJson(Uri uri, {bool bypassCache = false}) async {
    final cacheStore = _cacheStore;
    final path = uri.pathSegments.isEmpty
        ? uri.path
        : uri.pathSegments.last;
    final cacheKey = uri.toString();
    final shouldCache = cacheStore != null &&
        _cachePolicy.shouldCache(path) &&
        !bypassCache;
    if (_verboseLogging) {
      _logDebug(
        'Cache mode: ${_cacheMode.name}, enabled=${cacheStore != null}, shouldCache=$shouldCache',
      );
    }

    if (_cacheMode != CacheMode.refreshOnly && shouldCache) {
      final cached = await cacheStore.read(cacheKey);
      if (cached != null) {
        _logDebug('Cache hit ($path)');
        return jsonDecode(cached.body);
      }
    }

    if (_cacheMode == CacheMode.offlineOnly) {
      if (shouldCache) {
        final stale = await cacheStore.read(cacheKey, allowExpired: true);
        if (stale != null) {
          _logDebug('Cache stale hit ($path)');
          return jsonDecode(stale.body);
        }
      }
      throw YgoProDeckApiException(
        message: 'Offline-only mode: no cached response for $uri',
        statusCode: 0,
        url: uri,
      );
    }

    final response = await _getWithRetry(uri);
    _logDebug('Status ${response.statusCode} (${response.contentLength ?? 0}B)');
    if (_verboseLogging) {
      _logDebug('Response headers: ${response.headers}');
    }

    final body = response.body;
    if (response.statusCode != 200) {
      String message = 'Request failed';
      try {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic> && decoded['error'] is String) {
          message = decoded['error'] as String;
        }
      } catch (_) {
        message = body.isEmpty ? message : body;
      }
      _logDebug('Error: $message');
      if (_verboseLogging && body.isNotEmpty) {
        _logDebug('Error body: $body');
      }
      if (_allowStaleOnError && shouldCache) {
        final stale = await cacheStore.read(cacheKey, allowExpired: true);
        if (stale != null) {
          _logDebug('Returning stale cache for $path after error');
          return jsonDecode(stale.body);
        }
      }
      throw YgoProDeckApiException(
        message: message,
        statusCode: response.statusCode,
        url: uri,
      );
    }

    if (shouldCache) {
      final ttl = _cachePolicy.ttlForPath(path)!;
      final entry = CacheEntry(
        body: body,
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(ttl),
        key: cacheKey,
      );
      await cacheStore.write(cacheKey, entry);
      _logDebug('Cache write ($path) ttl=${ttl.inSeconds}s');
    }

    final decoded = jsonDecode(body);
    if (_verboseLogging) {
      _logDecodedSummary(decoded);
    }
    return decoded;
  }

  void _logDebug(String message) {
    if (_showDebugLogs) {
      _logger?.i(message);
    }
  }

  Future<http.Response> _getWithRetry(Uri uri) async {
    var attempt = 0;
    while (true) {
      attempt += 1;
      await _rateLimiter.throttle();
      _logDebug('GET $uri (attempt $attempt)');
      try {
        final response = await _httpClient.get(uri);
        if (attempt < _retryPolicy.maxAttempts &&
            _retryPolicy.shouldRetryResponse(response)) {
          final delay = _retryPolicy.delayForAttempt(attempt);
          _logDebug('Retrying in ${delay.inMilliseconds}ms');
          await Future<void>.delayed(delay);
          continue;
        }
        return response;
      } on Exception catch (e) {
        if (_verboseLogging) {
          _logDebug('Request error: $e');
        }
        if (attempt < _retryPolicy.maxAttempts &&
            _retryPolicy.shouldRetryException(e)) {
          final delay = _retryPolicy.delayForAttempt(attempt);
          _logDebug('Retrying after error in ${delay.inMilliseconds}ms');
          await Future<void>.delayed(delay);
          continue;
        }
        rethrow;
      }
    }
  }

  Uri _stripQuery(Uri uri) {
    return Uri(
      scheme: uri.scheme,
      userInfo: uri.userInfo,
      host: uri.host,
      port: uri.hasPort ? uri.port : null,
      path: uri.path,
    );
  }

  bool _isRandomParamsError(YgoProDeckApiException error) {
    final message = error.message.toLowerCase();
    return error.statusCode == 400 &&
        (message.contains('random') || message.contains('parameter'));
  }

  Future<Card> _getRandomCardViaCardInfo() async {
    final uri = _endpoint('cardinfo.php', {
      'num': '1',
      'offset': '0',
      'sort': 'random',
    });
    final json = await _getJson(uri, bypassCache: true);
    final response = CardInfoResponse.fromJson(json as Map<String, dynamic>);
    if (response.data.isEmpty) {
      throw YgoProDeckApiException(
        message: 'Random card fallback returned no results.',
        statusCode: 500,
        url: uri,
      );
    }
    return response.data.first;
  }

  void _logDecodedSummary(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      final keys = decoded.keys.join(', ');
      _logDebug('Response keys: $keys');
      final data = decoded['data'];
      if (data is List) {
        _logDebug('Response data count: ${data.length}');
      }
    } else if (decoded is List) {
      _logDebug('Response list count: ${decoded.length}');
    } else {
      _logDebug('Response type: ${decoded.runtimeType}');
    }
  }
}
