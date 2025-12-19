import 'banlist_info.dart';
import 'card_image.dart';
import 'card_price.dart';
import 'card_set.dart';
import 'misc_info.dart';

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

  final int id;
  final String name;
  final String type;
  final String frameType;
  final String desc;
  final String? ygoprodeckUrl;

  final int? atk;
  final int? def;
  final int? level;
  final String? race;
  final String? attribute;
  final int? scale;
  final int? linkval;
  final List<String>? linkmarkers;
  final String? archetype;

  final List<CardSet>? cardSets;
  final List<CardImage>? cardImages;
  final List<CardPrice>? cardPrices;
  final BanlistInfo? banlistInfo;
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
