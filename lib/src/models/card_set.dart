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

  final String setName;
  final String setCode;
  final String setRarity;
  final String setPrice;
  final String? setRarityCode;
  final String? setEdition;
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
