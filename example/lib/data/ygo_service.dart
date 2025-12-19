import 'package:ygoprodeck_api/ygoprodeck_api.dart';

class YgoService {
  YgoService({required CacheStore? cacheStore, YgoProDeckClient? client})
      : _cacheStore = cacheStore,
        _overrideClient = client {
    _client = _buildClient();
  }

  final CacheStore? _cacheStore;
  final YgoProDeckClient? _overrideClient;

  late YgoProDeckClient _client;
  CacheMode _cacheMode = CacheMode.normal;
  bool _showDebugLogs = true;
  bool _verboseLogging = true;

  CacheMode get cacheMode => _cacheMode;
  bool get showDebugLogs => _showDebugLogs;
  bool get verboseLogging => _verboseLogging;

  void updateSettings({
    CacheMode? cacheMode,
    bool? showDebugLogs,
    bool? verboseLogging,
  }) {
    final nextCacheMode = cacheMode ?? _cacheMode;
    final nextDebug = showDebugLogs ?? _showDebugLogs;
    final nextVerbose = verboseLogging ?? _verboseLogging;

    if (nextCacheMode == _cacheMode &&
        nextDebug == _showDebugLogs &&
        nextVerbose == _verboseLogging) {
      return;
    }

    _cacheMode = nextCacheMode;
    _showDebugLogs = nextDebug;
    _verboseLogging = nextVerbose;

    _client.close();
    _client = _buildClient();
  }

  YgoProDeckClient _buildClient() {
    if (_overrideClient != null) {
      return _overrideClient!;
    }
    return YgoProDeckClient(
      cacheStore: _cacheStore,
      cacheMode: _cacheMode,
      showDebugLogs: _showDebugLogs,
      verboseLogging: _verboseLogging,
    );
  }

  Future<CardInfoResponse> getCards(CardInfoQuery query) {
    return _client.getCards(query: query);
  }

  Future<Card> getRandomCard() {
    return _client.getRandomCard();
  }

  Future<List<CardArchetype>> getArchetypes() {
    return _client.getArchetypes();
  }

  Future<List<CardSetListItem>> getCardSets() {
    return _client.getCardSets();
  }

  Future<CheckDbVersion> checkDbVersion() {
    return _client.checkDbVersion();
  }

  Future<List<CacheEntryInfo>> listCacheEntries() async {
    final inspector = _cacheStore;
    if (inspector is CacheInspector) {
      return (inspector as CacheInspector).listEntries();
    }
    return [];
  }

  void dispose() {
    _client.close();
  }
}
