import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  test('BanlistInfo round trip', () {
    final info = BanlistInfo(banTcg: 'Limited', banOcg: 'Forbidden');
    final json = info.toJson();
    final decoded = BanlistInfo.fromJson(json);
    expect(decoded.banTcg, 'Limited');
    expect(decoded.banOcg, 'Forbidden');
  });

  test('CardImage round trip', () {
    final image = CardImage(
      id: 1,
      imageUrl: 'https://images/1.jpg',
      imageUrlSmall: 'https://images/1_small.jpg',
      imageUrlCropped: 'https://images/1_crop.jpg',
    );
    final decoded = CardImage.fromJson(image.toJson());
    expect(decoded.imageUrlSmall, image.imageUrlSmall);
  });

  test('CardPrice round trip', () {
    final price = CardPrice(
      cardmarketPrice: '1.00',
      tcgplayerPrice: '2.00',
      ebayPrice: '3.00',
      amazonPrice: '4.00',
      coolstuffincPrice: '5.00',
    );
    final decoded = CardPrice.fromJson(price.toJson());
    expect(decoded.tcgplayerPrice, '2.00');
  });

  test('CardSet round trip', () {
    final set = CardSet(
      setName: 'Starter',
      setCode: 'ABC-001',
      setRarity: 'Common',
      setPrice: '0.10',
      setRarityCode: '(C)',
      setEdition: '1st',
      setUrl: 'https://example.com',
    );
    final decoded = CardSet.fromJson(set.toJson());
    expect(decoded.setCode, 'ABC-001');
    expect(decoded.setEdition, '1st');
  });

  test('CardSetInfo round trip', () {
    final info = CardSetInfo(
      id: 1,
      name: 'Test',
      setName: 'Set',
      setCode: 'SET-001',
      setRarity: 'Ultra',
      setPrice: '1.23',
    );
    final decoded = CardSetInfo.fromJson(info.toJson());
    expect(decoded.setName, 'Set');
  });

  test('CardSetListItem round trip', () {
    final item = CardSetListItem(
      setName: 'Set',
      setCode: 'SET-001',
      numOfCards: 42,
      tcgDate: '2020-01-01',
    );
    final decoded = CardSetListItem.fromJson(item.toJson());
    expect(decoded.numOfCards, 42);
  });

  test('MetaInfo round trip', () {
    final meta = MetaInfo(
      currentRows: 1,
      totalRows: 10,
      rowsRemaining: 9,
      totalPages: 2,
      pagesRemaining: 1,
      nextPage: 'https://next',
      nextPageOffset: 5,
    );
    final decoded = MetaInfo.fromJson(meta.toJson());
    expect(decoded.nextPageOffset, 5);
  });

  test('MiscInfo round trip', () {
    final info = MiscInfo(
      betaName: 'Beta',
      views: 10,
      viewsweek: 2,
      upvotes: 3,
      downvotes: 1,
      formats: ['tcg'],
      treatedAs: 'Other',
      tcgDate: '2020-01-01',
      ocgDate: '2019-01-01',
      konamiId: 123,
      mdRarity: 'UR',
      hasEffect: 1,
      genesysPoints: 2,
    );
    final decoded = MiscInfo.fromJson(info.toJson());
    expect(decoded.formats, ['tcg']);
  });

  test('CardInfoResponse round trip', () {
    final response = CardInfoResponse(
      data: [
        Card(
          id: 1,
          name: 'Test',
          type: 'Normal Monster',
          frameType: 'normal',
          desc: 'Desc',
          ygoprodeckUrl: 'https://example.com',
        ),
      ],
      meta: MetaInfo(
        currentRows: 1,
        totalRows: 1,
        rowsRemaining: 0,
        totalPages: 1,
        pagesRemaining: 0,
      ),
    );
    final decoded = CardInfoResponse.fromJson(response.toJson());
    expect(decoded.data.first.name, 'Test');
  });

  test('YgoProDeckApiException string', () {
    final ex = YgoProDeckApiException(
      message: 'Bad',
      statusCode: 400,
      url: Uri.parse('https://example.com'),
    );
    expect(ex.toString(), contains('statusCode: 400'));
  });
}
