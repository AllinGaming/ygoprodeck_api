import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  test('query serializes list parameters', () {
    final query = CardInfoQuery(
      name: ['Baby Dragon', 'Time Wizard'],
      attribute: ['dark', 'light'],
      type: ['Effect Monster'],
      linkMarker: ['top', 'bottom-right'],
    );

    final params = query.toQueryParameters();
    expect(params['name'], 'Baby Dragon|Time Wizard');
    expect(params['attribute'], 'dark,light');
    expect(params['type'], 'Effect Monster');
    expect(params['linkmarker'], 'top,bottom-right');
  });

  test('query validates attribute values', () {
    final query = CardInfoQuery(attribute: ['wood']);
    expect(() => query.toQueryParameters(), throwsArgumentError);
  });

  test('query validates sort and date region values', () {
    final query = CardInfoQuery(sort: 'invalid', dateRegion: 'tcg');
    expect(() => query.toQueryParameters(), throwsArgumentError);

    final ok = CardInfoQuery(sort: 'name', dateRegion: 'ocg');
    expect(ok.toQueryParameters()['sort'], 'name');
  });
}
