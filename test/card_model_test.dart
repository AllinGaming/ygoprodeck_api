import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  test('Card.fromJson handles numeric values as strings', () {
    final card = Card.fromJson({
      'id': 1,
      'name': 'Test Card',
      'type': 'Effect Monster',
      'frameType': 'effect',
      'desc': 'Test',
      'atk': '2500',
      'def': '2100',
      'level': '8',
      'scale': '2',
      'linkval': '3',
    });

    expect(card.atk, 2500);
    expect(card.def, 2100);
    expect(card.level, 8);
    expect(card.scale, 2);
    expect(card.linkval, 3);
  });

  test('CheckDbVersion.fromJson handles string version', () {
    final version = CheckDbVersion.fromJson({
      'database_version': '123',
      'date': '2025-01-01',
    });

    expect(version.databaseVersion, 123);
  });
}
