import 'dart:io';

import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  test('CacheEntry round-trips with key', () {
    final entry = CacheEntry(
      body: '{"ok":true}',
      createdAt: DateTime.utc(2025, 1, 1),
      expiresAt: DateTime.utc(2025, 1, 2),
      key: 'https://example.com',
    );

    final json = entry.toJson();
    final decoded = CacheEntry.fromJson(json);

    expect(decoded.body, entry.body);
    expect(decoded.createdAt, entry.createdAt);
    expect(decoded.expiresAt, entry.expiresAt);
    expect(decoded.key, entry.key);
  });

  test('MemoryCacheStore returns entries via CacheInspector', () async {
    final store = MemoryCacheStore();
    final entry = CacheEntry(
      body: 'hello',
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
      key: 'k1',
    );

    await store.write('k1', entry);
    final entries = await store.listEntries();

    expect(entries.length, 1);
    expect(entries.first.key, 'k1');
    expect(entries.first.entry.body, 'hello');
  });

  test('CachePolicy default includes cardinfo.php', () {
    final policy = CachePolicy.defaultPolicy();
    expect(policy.shouldCache('cardinfo.php'), isTrue);
    expect(policy.shouldCache('randomcard.php'), isFalse);
  });

  test('FileCacheStore lists entries with original key', () async {
    final dir = await Directory.systemTemp.createTemp('ygo-cache-test');
    final store = FileCacheStore(basePath: dir.path);
    final entry = CacheEntry(
      body: '{"data":[]}',
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
      key: 'https://example.com/path',
    );

    await store.write('https://example.com/path', entry);
    final entries = await store.listEntries();

    expect(entries.length, 1);
    expect(entries.first.key, 'https://example.com/path');

    await dir.delete(recursive: true);
  });
}
