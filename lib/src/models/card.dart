import 'banlist_info.dart';
import 'card_image.dart';
import 'card_price.dart';
import 'card_set.dart';
import 'misc_info.dart';

/// Card data returned by `cardinfo.php`.
class Card {
  Card({
    required this.id,
    required this.name,
    required this.type,
    required this.frameType,
    required this.desc,
    required this.ygoprodeckUrl,
    this.atk,
    this.def,
    this.level,
    this.race,
    this.attribute,
    this.scale,
    this.linkval,
    this.linkmarkers,
    this.archetype,
    this.cardSets,
    this.cardImages,
    this.cardPrices,
    this.banlistInfo,
    this.miscInfo,
  });

  /// Card ID or passcode.
  final int id;

  /// Card name.
  final String name;

  /// Card type (e.g., Effect Monster, Spell Card).
  final String type;

  /// Frame type (e.g., effect, spell, xyz).
  final String frameType;

  /// Card description/effect text.
  final String desc;

  /// YGOPRODeck card page URL.
  final String? ygoprodeckUrl;

  /// ATK value.
  final int? atk;

  /// DEF value.
  final int? def;

  /// Level or Rank.
  final int? level;

  /// Race/type (e.g., Spellcaster).
  final String? race;

  /// Attribute (e.g., DARK).
  final String? attribute;

  /// Pendulum scale.
  final int? scale;

  /// Link value.
  final int? linkval;

  /// Link markers.
  final List<String>? linkmarkers;

  /// Archetype name.
  final String? archetype;

  /// Card sets for this card.
  final List<CardSet>? cardSets;

  /// Card images for this card.
  final List<CardImage>? cardImages;

  /// Vendor prices for this card.
  final List<CardPrice>? cardPrices;

  /// Banlist information.
  final BanlistInfo? banlistInfo;

  /// Misc metadata when `misc=yes`.
  final List<MiscInfo>? miscInfo;

  factory Card.fromJson(Map<String, dynamic> json) {
    int? asInt(dynamic value) {
      if (value == null) {
        return null;
      }
      if (value is int) {
        return value;
      }
      if (value is num) {
        return value.toInt();
      }
      return int.tryParse(value.toString());
    }

    return Card(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      frameType: json['frameType'] as String,
      desc: json['desc'] as String,
      ygoprodeckUrl: json['ygoprodeck_url'] as String?,
      atk: asInt(json['atk']),
      def: asInt(json['def']),
      level: asInt(json['level']),
      race: json['race'] as String?,
      attribute: json['attribute'] as String?,
      scale: asInt(json['scale']),
      linkval: asInt(json['linkval']),
      linkmarkers: (json['linkmarkers'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      archetype: json['archetype'] as String?,
      cardSets: (json['card_sets'] as List<dynamic>?)
          ?.map((item) => CardSet.fromJson(item as Map<String, dynamic>))
          .toList(),
      cardImages: (json['card_images'] as List<dynamic>?)
          ?.map((item) => CardImage.fromJson(item as Map<String, dynamic>))
          .toList(),
      cardPrices: (json['card_prices'] as List<dynamic>?)
          ?.map((item) => CardPrice.fromJson(item as Map<String, dynamic>))
          .toList(),
      banlistInfo: json['banlist_info'] == null
          ? null
          : BanlistInfo.fromJson(json['banlist_info'] as Map<String, dynamic>),
      miscInfo: (json['misc_info'] as List<dynamic>?)
          ?.map((item) => MiscInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'frameType': frameType,
      'desc': desc,
      if (ygoprodeckUrl != null) 'ygoprodeck_url': ygoprodeckUrl,
      if (atk != null) 'atk': atk,
      if (def != null) 'def': def,
      if (level != null) 'level': level,
      if (race != null) 'race': race,
      if (attribute != null) 'attribute': attribute,
      if (scale != null) 'scale': scale,
      if (linkval != null) 'linkval': linkval,
      if (linkmarkers != null) 'linkmarkers': linkmarkers,
      if (archetype != null) 'archetype': archetype,
      if (cardSets != null)
        'card_sets': cardSets!.map((item) => item.toJson()).toList(),
      if (cardImages != null)
        'card_images': cardImages!.map((item) => item.toJson()).toList(),
      if (cardPrices != null)
        'card_prices': cardPrices!.map((item) => item.toJson()).toList(),
      if (banlistInfo != null) 'banlist_info': banlistInfo!.toJson(),
      if (miscInfo != null)
        'misc_info': miscInfo!.map((item) => item.toJson()).toList(),
    };
  }
}
