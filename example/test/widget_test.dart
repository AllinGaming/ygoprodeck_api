import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';
import 'package:ygoprodeck_api_example/app.dart';
import 'package:ygoprodeck_api_example/data/ygo_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app boots', (tester) async {
    await _registerTestDependencies();

    await tester.pumpWidget(const YgoExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('YGOPRODeck API Example'), findsWidgets);
  });
}

Future<void> _registerTestDependencies() async {
  final getIt = GetIt.instance;
  if (getIt.isRegistered<YgoService>()) {
    await getIt.reset();
  }

  final mockClient = MockClient((_) async {
    return http.Response('{"data":[]}', 200);
  });

  final client = YgoProDeckClient(
    httpClient: mockClient,
    enableCaching: false,
  );

  getIt.registerSingleton<YgoService>(
    YgoService(cacheStore: MemoryCacheStore(), client: client),
  );
}
