# YGOPRODeck API (Dart)

[![pub package](https://img.shields.io/pub/v/ygoprodeck_api.svg)](https://pub.dev/packages/ygoprodeck_api)
[![CI](https://github.com/AllinGaming/ygoprodeck_api/actions/workflows/ci.yml/badge.svg)](https://github.com/AllinGaming/ygoprodeck_api/actions/workflows/ci.yml)
[![Example](https://img.shields.io/badge/example-live-blue)](https://allingaming.github.io/ygoprodeck_api/)
[![coverage](https://img.shields.io/endpoint?url=https://allingaming.github.io/ygoprodeck_api/coverage/coverage.json)](https://allingaming.github.io/ygoprodeck_api/coverage/lcov.info)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Dart wrapper for the YGOPRODeck Yu-Gi-Oh! API (v7).

API docs: https://ygoprodeck.com/api-guide/

## Features

- Typed models for cards, sets, archetypes, and DB version.
- Query builder for `cardinfo.php` filters.
- Safe error handling with clear exceptions.
- Optional colored debug logging via `logger`.
- Offline-first caching with configurable TTLs.
- Built-in rate limiting (20 requests/sec) to respect API rules.
- Local validation for known enums (attribute, race, type, format, etc).
- Automatic retry with backoff for transient 5xx errors.

## Install

```bash
dart pub add ygoprodeck_api
```

## Usage

```dart
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() async {
  final api = YgoProDeckClient(showDebugLogs: true);

  final response = await api.getCards(
    query: CardInfoQuery(
      name: ['Dark Magician'],
      misc: true,
    ),
  );

  final card = response.data.first;
  print('${card.name} - ${card.type}');

  api.close();
}
```

### Query builder highlights

```dart
final response = await api.getCards(
  query: CardInfoQuery(
    archetype: 'Blue-Eyes',
    attribute: ['light'],
    level: StatFilter(value: 8, comparator: StatComparator.gte),
    sort: 'atk',
    num: 10,
    offset: 0,
  ),
);
```

### More examples

Random card:

```dart
final api = YgoProDeckClient();
final card = await api.getRandomCard();
print(card.name);
```

Fetch card sets:

```dart
final api = YgoProDeckClient();
final sets = await api.getCardSets();
print('Sets: ${sets.length}');
```

Check database version:

```dart
final api = YgoProDeckClient();
final version = await api.checkDbVersion();
print('DB v${version.databaseVersion} (${version.databaseVersionDate})');
```

Offline-first with file cache:

```dart
final api = YgoProDeckClient(
  cacheStore: FileCacheStore(basePath: '.cache/ygoprodeck'),
  cacheMode: CacheMode.normal,
);
```

## Important API Notes

- **Do not hotlink images**. Download and host images yourself or you risk IP blacklisting.
- **Rate limit**: 20 requests per second. Exceeding this blocks you for 1 hour.
- **Random card endpoint** (`randomcard.php`) does not accept query parameters.
- Invalid parameters return `400` with a JSON error message.
- This package uses the YGOPRODeck API. Please follow their rules and guidance: https://ygoprodeck.com/api-guide/

## Card Prices

The API returns a `card_prices` array with vendor pricing:

- `cardmarket_price` (EUR)
- `coolstuffinc_price` (USD)
- `tcgplayer_price` (USD)
- `ebay_price` (USD)
- `amazon_price` (USD)

## Logging

Set `showDebugLogs: true` to enable colored request/response logging using `logger`.
You can also inject your own `Logger` instance.
Use `verboseLogging: true` to log query params and response summaries.

## Caching (offline-first)

The client can cache responses to disk or memory and serve cached content first.

- Default TTLs follow API guidance (e.g. `cardinfo.php` cached for 2 days).
- `randomcard.php` is never cached.
- A memory cache is enabled by default. Use `enableCaching: false` to disable.
- Use `CacheMode.offlineOnly` to avoid network calls.

Example with file cache:

```dart
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() async {
  final api = YgoProDeckClient(
    cacheStore: FileCacheStore(basePath: '.cache/ygoprodeck'),
    cacheMode: CacheMode.normal,
    showDebugLogs: true,
  );

  final response = await api.getCards(
    query: CardInfoQuery(name: ['Dark Magician']),
  );
  print(response.data.first.name);

  api.close();
}
```

Note: `FileCacheStore` uses `dart:io` and is not available for web targets.
For web, use `WebStorageCacheStore` to persist to `localStorage` (size limits apply).

Web example:

```dart
final api = YgoProDeckClient(
  cacheStore: WebStorageCacheStore(prefix: 'ygoprodeck'),
);
```

## Rate limiting

By default the client limits network calls to 20 requests per second.
To disable it:

```dart
final api = YgoProDeckClient(
  rateLimiter: RateLimiter.perSecond(0),
);
```

## Retries

By default the client retries transient 5xx responses with exponential backoff.
To customize or disable retries:

```dart
final api = YgoProDeckClient(
  retryPolicy: RetryPolicy(maxAttempts: 1),
);
```

To override TTLs:

```dart
final api = YgoProDeckClient(
  cacheStore: FileCacheStore(basePath: '.cache/ygoprodeck'),
  cachePolicy: CachePolicy(ttlByPath: {
    'cardinfo.php': Duration(days: 2),
    'checkDBVer.php': Duration(minutes: 10),
    'randomcard.php': null,
  }),
);
```

## Example

See `example/README.md` for a full runnable Flutter example app.
Hosted example (web): https://allingaming.github.io/ygoprodeck_api/
Requires the Flutter SDK; run `flutter pub get` in the `example` directory.

## Attribution

Yu-Gi-Oh! card data and images are provided by the YGOPRODeck API.
Please review their API guide and usage terms: https://ygoprodeck.com/api-guide/

## Support

If you open an issue or feature request, it will be reviewed and addressed as time permits.

## License

MIT (see `LICENSE`).
