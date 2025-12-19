/// A card set entry for a card.
class CardSet {
  CardSet({
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setPrice,
    this.setRarityCode,
    this.setEdition,
    this.setUrl,
  });

  /// Set name.
  final String setName;

  /// Set code.
  final String setCode;

  /// Set rarity.
  final String setRarity;

  /// Set price (USD).
  final String setPrice;

  /// Set rarity code (if provided).
  final String? setRarityCode;

  /// Set edition (if provided).
  final String? setEdition;

  /// Set URL (if provided).
  final String? setUrl;

  factory CardSet.fromJson(Map<String, dynamic> json) {
    return CardSet(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setPrice: json['set_price'] as String,
      setRarityCode: json['set_rarity_code'] as String?,
      setEdition: json['set_edition'] as String?,
      setUrl: json['set_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'set_name': setName,
      'set_code': setCode,
      'set_rarity': setRarity,
      if (setRarityCode != null) 'set_rarity_code': setRarityCode,
      if (setEdition != null) 'set_edition': setEdition,
      if (setUrl != null) 'set_url': setUrl,
      'set_price': setPrice,
    };
  }
}
