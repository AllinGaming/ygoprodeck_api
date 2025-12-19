export 'cache_common.dart';

import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

import 'cache_common.dart';

class FileCacheStore implements CacheStore, CacheInspector {
  FileCacheStore({required String basePath}) : _baseDir = Directory(basePath) {
    if (!_baseDir.existsSync()) {
      _baseDir.createSync(recursive: true);
    }
  }

  final Directory _baseDir;

  @override
  Future<CacheEntry?> read(String key, {bool allowExpired = false}) async {
    final file = _fileForKey(key);
    if (!await file.exists()) {
      return null;
    }
    try {
      final contents = await file.readAsString();
      final jsonMap = jsonDecode(contents) as Map<String, dynamic>;
      final entry = CacheEntry.fromJson(jsonMap);
      if (!allowExpired && entry.isExpired) {
        await file.delete();
        return null;
      }
      return entry;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String key, CacheEntry entry) async {
    final file = _fileForKey(key);
    final payload = jsonEncode(entry.toJson());
    await file.writeAsString(payload, flush: true);
  }

  @override
  Future<void> delete(String key) async {
    final file = _fileForKey(key);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<List<CacheEntryInfo>> listEntries() async {
    final entries = <CacheEntryInfo>[];
    if (!await _baseDir.exists()) {
      return entries;
    }
    final files = _baseDir.listSync().whereType<File>();
    for (final file in files) {
      try {
        final contents = await file.readAsString();
        final jsonMap = jsonDecode(contents) as Map<String, dynamic>;
        final entry = CacheEntry.fromJson(jsonMap);
        final key = entry.key ?? file.uri.pathSegments.last;
        entries.add(CacheEntryInfo(key: key, entry: entry));
      } catch (_) {}
    }
    return entries;
  }

  File _fileForKey(String key) {
    final digest = sha256.convert(utf8.encode(key)).toString();
    return File('${_baseDir.path}/$digest.json');
  }
}

class WebStorageCacheStore implements CacheStore, CacheInspector {
  WebStorageCacheStore({String? prefix}) {
    throw UnsupportedError('WebStorageCacheStore is only available on web.');
  }

  @override
  Future<CacheEntry?> read(String key, {bool allowExpired = false}) async {
    return null;
  }

  @override
  Future<void> write(String key, CacheEntry entry) async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<List<CacheEntryInfo>> listEntries() async {
    return [];
  }
}
