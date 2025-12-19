import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';
import 'package:ygoprodeck_api_example/app.dart';
import 'package:ygoprodeck_api_example/data/ygo_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app boots and shows search tab', (tester) async {
    await _registerTestDependencies();

    await tester.pumpWidget(const YgoExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Search'), findsOneWidget);
    expect(find.text('YGOPRODeck API Example'), findsOneWidget);
  });
}

Future<void> _registerTestDependencies() async {
  final getIt = GetIt.instance;
  if (getIt.isRegistered<YgoService>()) {
    await getIt.reset();
  }

  final mockClient = MockClient((request) async {
    final path = request.url.pathSegments.last;
    if (path == 'cardinfo.php') {
      return http.Response(
        jsonEncode({
          'data': [
            {
              'id': 1,
              'name': 'Test Card',
              'type': 'Effect Monster',
              'frameType': 'effect',
              'desc': 'Test description',
            }
          ]
        }),
        200,
      );
    }
    if (path == 'checkDBVer.php') {
      return http.Response(
        jsonEncode({'database_version': 1, 'date': '2025-01-01'}),
        200,
      );
    }
    if (path == 'archetypes.php') {
      return http.Response(jsonEncode([]), 200);
    }
    if (path == 'cardsets.php') {
      return http.Response(jsonEncode([]), 200);
    }
    if (path == 'randomcard.php') {
      return http.Response(
        jsonEncode({
          'id': 2,
          'name': 'Random Card',
          'type': 'Normal Monster',
          'frameType': 'normal',
          'desc': 'Random description',
        }),
        200,
      );
    }
    return http.Response('Not Found', 404);
  });

  final client = YgoProDeckClient(
    httpClient: mockClient,
    enableCaching: false,
  );

  getIt.registerSingleton<YgoService>(
    YgoService(cacheStore: MemoryCacheStore(), client: client),
  );
}
