import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  const cardInfoJson = {
    'data': [
      {
        'id': 123,
        'name': 'Test Card',
        'type': 'Effect Monster',
        'frameType': 'effect',
        'desc': 'Test description'
      }
    ]
  };

  test('getCards rejects name + id combination', () async {
    final client = YgoProDeckClient(
      httpClient: MockClient((_) async {
        return http.Response(jsonEncode(cardInfoJson), 200);
      }),
    );

    expect(
      () => client.getCards(
        query: CardInfoQuery(name: ['Test'], id: [123]),
      ),
      throwsArgumentError,
    );
  });

  test('uses cache to avoid duplicate network calls', () async {
    var calls = 0;
    final cacheStore = MemoryCacheStore();
    final client = YgoProDeckClient(
      cacheStore: cacheStore,
      httpClient: MockClient((_) async {
        calls += 1;
        return http.Response(jsonEncode(cardInfoJson), 200);
      }),
    );

    await client.getCards(query: CardInfoQuery(name: ['Test']));
    await client.getCards(query: CardInfoQuery(name: ['Test']));

    expect(calls, 1);
  });

  test('offlineOnly serves cached response', () async {
    var calls = 0;
    final cacheStore = MemoryCacheStore();
    final onlineClient = YgoProDeckClient(
      cacheStore: cacheStore,
      httpClient: MockClient((_) async {
        calls += 1;
        return http.Response(jsonEncode(cardInfoJson), 200);
      }),
    );

    await onlineClient.getCards(query: CardInfoQuery(name: ['Test']));

    final offlineClient = YgoProDeckClient(
      cacheStore: cacheStore,
      cacheMode: CacheMode.offlineOnly,
      httpClient: MockClient((_) async {
        calls += 1;
        return http.Response('no', 500);
      }),
    );

    final response = await offlineClient.getCards(
      query: CardInfoQuery(name: ['Test']),
    );

    expect(response.data.first.name, 'Test Card');
    expect(calls, 1);
  });

  test('retries transient 5xx responses', () async {
    var calls = 0;
    final client = YgoProDeckClient(
      retryPolicy: RetryPolicy(
        maxAttempts: 3,
        baseDelay: Duration.zero,
        maxDelay: Duration.zero,
        jitter: false,
      ),
      httpClient: MockClient((_) async {
        calls += 1;
        if (calls < 3) {
          return http.Response('server error', 500);
        }
        return http.Response(jsonEncode(cardInfoJson), 200);
      }),
    );

    final response =
        await client.getCards(query: CardInfoQuery(name: ['Test']));
    expect(response.data.first.id, 123);
    expect(calls, 3);
  });
}
