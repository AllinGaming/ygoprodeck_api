class CardPrice {
  CardPrice({
    required this.cardmarketPrice,
    required this.tcgplayerPrice,
    required this.ebayPrice,
    required this.amazonPrice,
    required this.coolstuffincPrice,
  });

  final String cardmarketPrice;
  final String tcgplayerPrice;
  final String ebayPrice;
  final String amazonPrice;
  final String coolstuffincPrice;

  factory CardPrice.fromJson(Map<String, dynamic> json) {
    return CardPrice(
      cardmarketPrice: json['cardmarket_price'] as String,
      tcgplayerPrice: json['tcgplayer_price'] as String,
      ebayPrice: json['ebay_price'] as String,
      amazonPrice: json['amazon_price'] as String,
      coolstuffincPrice: json['coolstuffinc_price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardmarket_price': cardmarketPrice,
      'tcgplayer_price': tcgplayerPrice,
      'ebay_price': ebayPrice,
      'amazon_price': amazonPrice,
      'coolstuffinc_price': coolstuffincPrice,
    };
  }
}
