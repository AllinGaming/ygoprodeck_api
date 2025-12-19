export 'cache_common.dart';

// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:html';

import 'cache_common.dart';

class FileCacheStore implements CacheStore {
  FileCacheStore({required String basePath}) {
    throw UnsupportedError('FileCacheStore is not supported on web targets.');
  }

  @override
  Future<CacheEntry?> read(String key, {bool allowExpired = false}) async {
    return null;
  }

  @override
  Future<void> write(String key, CacheEntry entry) async {}

  @override
  Future<void> delete(String key) async {}
}

class WebStorageCacheStore implements CacheStore, CacheInspector {
  WebStorageCacheStore({String? prefix})
      : _prefix = prefix ?? 'ygoprodeck_cache';

  final String _prefix;

  @override
  Future<CacheEntry?> read(String key, {bool allowExpired = false}) async {
    final storageKey = _storageKey(key);
    final raw = window.localStorage[storageKey];
    if (raw == null) {
      return null;
    }
    try {
      final jsonMap = jsonDecode(raw) as Map<String, dynamic>;
      final entry = CacheEntry.fromJson(jsonMap);
      if (!allowExpired && entry.isExpired) {
        window.localStorage.remove(storageKey);
        return null;
      }
      return entry;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String key, CacheEntry entry) async {
    final storageKey = _storageKey(key);
    final payload = jsonEncode(entry.toJson());
    window.localStorage[storageKey] = payload;
  }

  @override
  Future<void> delete(String key) async {
    window.localStorage.remove(_storageKey(key));
  }

  @override
  Future<List<CacheEntryInfo>> listEntries() async {
    final entries = <CacheEntryInfo>[];
    for (final key in window.localStorage.keys) {
      if (!key.startsWith('$_prefix::')) {
        continue;
      }
      final raw = window.localStorage[key];
      if (raw == null) {
        continue;
      }
      try {
        final jsonMap = jsonDecode(raw) as Map<String, dynamic>;
        final entry = CacheEntry.fromJson(jsonMap);
        final originalKey = entry.key ?? key.substring(_prefix.length + 2);
        entries.add(CacheEntryInfo(key: originalKey, entry: entry));
      } catch (_) {}
    }
    return entries;
  }

  String _storageKey(String key) => '$_prefix::$key';
}
