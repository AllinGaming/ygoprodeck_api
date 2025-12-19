/// Detailed set information for a specific set code.
class CardSetInfo {
  CardSetInfo({
    required this.id,
    required this.name,
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setPrice,
  });

  /// Card ID.
  final int id;

  /// Card name.
  final String name;

  /// Set name.
  final String setName;

  /// Set code.
  final String setCode;

  /// Set rarity.
  final String setRarity;

  /// Set price (USD).
  final String setPrice;

  factory CardSetInfo.fromJson(Map<String, dynamic> json) {
    return CardSetInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setPrice: json['set_price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'set_name': setName,
      'set_code': setCode,
      'set_rarity': setRarity,
      'set_price': setPrice,
    };
  }
}
