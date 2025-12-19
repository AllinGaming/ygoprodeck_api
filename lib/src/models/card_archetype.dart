class CardArchetype {
  CardArchetype({
    required this.archetypeName,
  });

  final String archetypeName;

  factory CardArchetype.fromJson(Map<String, dynamic> json) {
    return CardArchetype(
      archetypeName: json['archetype_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'archetype_name': archetypeName,
    };
  }
}
