enum StatComparator { lt, lte, gt, gte, eq }

class StatFilter {
  StatFilter({
    required this.value,
    this.comparator = StatComparator.eq,
  });

  final int value;
  final StatComparator comparator;

  String toParameter() {
    switch (comparator) {
      case StatComparator.lt:
        return 'lt$value';
      case StatComparator.lte:
        return 'lte$value';
      case StatComparator.gt:
        return 'gt$value';
      case StatComparator.gte:
        return 'gte$value';
      case StatComparator.eq:
        return value.toString();
    }
  }
}

class CardInfoQuery {
  CardInfoQuery({
    this.name,
    this.fuzzyName,
    this.id,
    this.konamiId,
    this.type,
    this.atk,
    this.def,
    this.level,
    this.race,
    this.attribute,
    this.link,
    this.linkMarker,
    this.scale,
    this.cardSet,
    this.archetype,
    this.banlist,
    this.sort,
    this.format,
    this.misc,
    this.staple,
    this.hasEffect,
    this.startDate,
    this.endDate,
    this.dateRegion,
    this.language,
    this.num,
    this.offset,
    this.tcgplayerData,
  });

  final List<String>? name;
  final String? fuzzyName;
  final List<int>? id;
  final int? konamiId;
  final List<String>? type;
  final StatFilter? atk;
  final StatFilter? def;
  final StatFilter? level;
  final List<String>? race;
  final List<String>? attribute;
  final int? link;
  final List<String>? linkMarker;
  final int? scale;
  final String? cardSet;
  final String? archetype;
  final String? banlist;
  final String? sort;
  final String? format;
  final bool? misc;
  final bool? staple;
  final bool? hasEffect;
  final String? startDate;
  final String? endDate;
  final String? dateRegion;
  final String? language;
  final int? num;
  final int? offset;
  final bool? tcgplayerData;

  Map<String, String> toQueryParameters() {
    _validate();
    final params = <String, String>{};

    if (name != null && name!.isNotEmpty) {
      params['name'] = name!.join('|');
    }
    if (fuzzyName != null) {
      params['fname'] = fuzzyName!;
    }
    if (id != null && id!.isNotEmpty) {
      params['id'] = id!.join(',');
    }
    if (konamiId != null) {
      params['konami_id'] = konamiId!.toString();
    }
    if (type != null && type!.isNotEmpty) {
      params['type'] = type!.join(',');
    }
    if (atk != null) {
      params['atk'] = atk!.toParameter();
    }
    if (def != null) {
      params['def'] = def!.toParameter();
    }
    if (level != null) {
      params['level'] = level!.toParameter();
    }
    if (race != null && race!.isNotEmpty) {
      params['race'] = race!.join(',');
    }
    if (attribute != null && attribute!.isNotEmpty) {
      params['attribute'] = attribute!.join(',');
    }
    if (link != null) {
      params['link'] = link!.toString();
    }
    if (linkMarker != null && linkMarker!.isNotEmpty) {
      params['linkmarker'] = linkMarker!.join(',');
    }
    if (scale != null) {
      params['scale'] = scale!.toString();
    }
    if (cardSet != null) {
      params['cardset'] = cardSet!;
    }
    if (archetype != null) {
      params['archetype'] = archetype!;
    }
    if (banlist != null) {
      params['banlist'] = banlist!;
    }
    if (sort != null) {
      params['sort'] = sort!;
    }
    if (format != null) {
      params['format'] = format!;
    }
    if (misc != null) {
      params['misc'] = misc! ? 'yes' : 'no';
    }
    if (staple != null) {
      params['staple'] = staple! ? 'yes' : 'no';
    }
    if (hasEffect != null) {
      params['has_effect'] = hasEffect! ? 'true' : 'false';
    }
    if (startDate != null) {
      params['startdate'] = startDate!;
    }
    if (endDate != null) {
      params['enddate'] = endDate!;
    }
    if (dateRegion != null) {
      params['dateregion'] = dateRegion!;
    }
    if (language != null) {
      params['language'] = language!;
    }
    if (num != null) {
      params['num'] = num!.toString();
    }
    if (offset != null) {
      params['offset'] = offset!.toString();
    }
    if (tcgplayerData != null) {
      params['tcgplayer_data'] = tcgplayerData! ? 'yes' : 'no';
    }

    return params;
  }

  void _validate() {
    _validateList('attribute', attribute, _attributeValues);
    _validateList('race', race, _raceValues);
    _validateList('type', type, _typeValues);
    _validateList('linkmarker', linkMarker, _linkMarkerValues);
    _validateValue('format', format, _formatValues);
    _validateValue('banlist', banlist, _banlistValues);
    _validateValue('sort', sort, _sortValues);
    _validateValue('dateregion', dateRegion, _dateRegionValues);
    _validateValue('language', language, _languageValues);
    if (num != null && num! < 0) {
      throw ArgumentError('num must be >= 0.');
    }
    if (offset != null && offset! < 0) {
      throw ArgumentError('offset must be >= 0.');
    }
  }

  void _validateList(String name, List<String>? values, Set<String> allowed) {
    if (values == null) {
      return;
    }
    for (final value in values) {
      final normalized = value.toLowerCase().trim();
      if (!allowed.contains(normalized)) {
        throw ArgumentError(
          'Invalid $name value: $value. Allowed values: ${allowed.join(', ')}',
        );
      }
    }
  }

  void _validateValue(String name, String? value, Set<String> allowed) {
    if (value == null) {
      return;
    }
    final normalized = value.toLowerCase().trim();
    if (!allowed.contains(normalized)) {
      throw ArgumentError(
        'Invalid $name value: $value. Allowed values: ${allowed.join(', ')}',
      );
    }
  }
}

final Set<String> _attributeValues = {
  'dark',
  'earth',
  'fire',
  'light',
  'water',
  'wind',
  'divine',
};

final Set<String> _raceValues = {
  'aqua',
  'beast',
  'beast-warrior',
  'creator-god',
  'cyberse',
  'dinosaur',
  'divine-beast',
  'dragon',
  'fairy',
  'fiend',
  'fish',
  'insect',
  'machine',
  'plant',
  'psychic',
  'pyro',
  'reptile',
  'rock',
  'sea serpent',
  'spellcaster',
  'thunder',
  'warrior',
  'winged beast',
  'wyrm',
  'zombie',
  'normal',
  'field',
  'equip',
  'continuous',
  'quick-play',
  'ritual',
  'counter',
};

final Set<String> _typeValues = {
  'effect monster',
  'flip effect monster',
  'flip tuner effect monster',
  'gemini monster',
  'normal monster',
  'normal tuner monster',
  'pendulum effect monster',
  'pendulum effect ritual monster',
  'pendulum flip effect monster',
  'pendulum normal monster',
  'pendulum tuner effect monster',
  'ritual effect monster',
  'ritual monster',
  'spell card',
  'spirit monster',
  'toon monster',
  'trap card',
  'tuner monster',
  'union effect monster',
  'fusion monster',
  'link monster',
  'pendulum effect fusion monster',
  'synchro monster',
  'synchro pendulum effect monster',
  'synchro tuner monster',
  'xyz monster',
  'xyz pendulum effect monster',
  'skill card',
  'token',
};

final Set<String> _linkMarkerValues = {
  'top',
  'bottom',
  'left',
  'right',
  'bottom-left',
  'bottom-right',
  'top-left',
  'top-right',
};

final Set<String> _formatValues = {
  'tcg',
  'goat',
  'ocg goat',
  'speed duel',
  'master duel',
  'rush duel',
  'duel links',
  'genesys',
};

final Set<String> _banlistValues = {
  'tcg',
  'ocg',
  'goat',
};

final Set<String> _languageValues = {
  'fr',
  'de',
  'it',
  'pt',
};

final Set<String> _sortValues = {
  'atk',
  'def',
  'name',
  'type',
  'level',
  'id',
  'new',
  'random',
};

final Set<String> _dateRegionValues = {
  'tcg',
  'ocg',
};
