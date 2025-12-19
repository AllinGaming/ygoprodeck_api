class CacheEntry {
  CacheEntry({
    required this.body,
    required this.createdAt,
    required this.expiresAt,
    this.key,
  });

  final String body;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String? key;

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      if (key != null) 'key': key,
    };
  }

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      body: json['body'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      key: json['key'] as String?,
    );
  }
}

abstract class CacheStore {
  Future<CacheEntry?> read(String key, {bool allowExpired = false});
  Future<void> write(String key, CacheEntry entry);
  Future<void> delete(String key);
}

class CacheEntryInfo {
  CacheEntryInfo({required this.key, required this.entry});

  final String key;
  final CacheEntry entry;
}

abstract class CacheInspector {
  Future<List<CacheEntryInfo>> listEntries();
}

class MemoryCacheStore implements CacheStore, CacheInspector {
  final Map<String, CacheEntry> _cache = {};

  @override
  Future<CacheEntry?> read(String key, {bool allowExpired = false}) async {
    final entry = _cache[key];
    if (entry == null) {
      return null;
    }
    if (!allowExpired && entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry;
  }

  @override
  Future<void> write(String key, CacheEntry entry) async {
    _cache[key] = entry;
  }

  @override
  Future<void> delete(String key) async {
    _cache.remove(key);
  }

  @override
  Future<List<CacheEntryInfo>> listEntries() async {
    return _cache.entries
        .map((entry) => CacheEntryInfo(key: entry.key, entry: entry.value))
        .toList();
  }
}

class CachePolicy {
  CachePolicy({required Map<String, Duration?> ttlByPath})
      : _ttlByPath = ttlByPath;

  final Map<String, Duration?> _ttlByPath;

  Duration? ttlForPath(String path) => _ttlByPath[path];

  bool shouldCache(String path) => ttlForPath(path) != null;

  factory CachePolicy.defaultPolicy() {
    return CachePolicy(ttlByPath: {
      'cardinfo.php': const Duration(days: 2),
      'cardsets.php': const Duration(days: 1),
      'cardsetsinfo.php': const Duration(days: 1),
      'archetypes.php': const Duration(days: 1),
      'checkDBVer.php': const Duration(hours: 1),
      'randomcard.php': null,
    });
  }
}

enum CacheMode {
  normal,
  offlineOnly,
  refreshOnly,
}

class RateLimiter {
  RateLimiter._(this._limit, this._window);

  final int _limit;
  final Duration _window;
  final List<DateTime> _timestamps = [];

  factory RateLimiter.perSecond(int limit) {
    return RateLimiter._(limit, const Duration(seconds: 1));
  }

  Future<void> throttle() async {
    if (_limit <= 0) {
      return;
    }
    final now = DateTime.now();
    _timestamps.removeWhere((time) => now.difference(time) >= _window);
    if (_timestamps.length < _limit) {
      _timestamps.add(now);
      return;
    }
    final oldest = _timestamps.first;
    final waitFor = _window - now.difference(oldest);
    if (waitFor.isNegative) {
      _timestamps.add(now);
      return;
    }
    await Future<void>.delayed(waitFor);
    final afterWait = DateTime.now();
    _timestamps.removeWhere((time) => afterWait.difference(time) >= _window);
    _timestamps.add(afterWait);
  }
}
