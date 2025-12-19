/// Additional metadata returned when `misc=yes`.
class MiscInfo {
  MiscInfo({
    this.betaName,
    this.views,
    this.viewsweek,
    this.upvotes,
    this.downvotes,
    this.formats,
    this.treatedAs,
    this.tcgDate,
    this.ocgDate,
    this.konamiId,
    this.mdRarity,
    this.hasEffect,
    this.genesysPoints,
  });

  /// Temporary or beta card name.
  final String? betaName;

  /// Total views.
  final int? views;

  /// Views this week.
  final int? viewsweek;

  /// Upvotes.
  final int? upvotes;

  /// Downvotes.
  final int? downvotes;

  /// Available formats.
  final List<String>? formats;

  /// Treated-as name.
  final String? treatedAs;

  /// TCG release date.
  final String? tcgDate;

  /// OCG release date.
  final String? ocgDate;

  /// Konami ID.
  final int? konamiId;

  /// Master Duel rarity.
  final String? mdRarity;

  /// Whether the card has an effect.
  final int? hasEffect;

  /// Genesys points (format=genesys).
  final int? genesysPoints;

  factory MiscInfo.fromJson(Map<String, dynamic> json) {
    return MiscInfo(
      betaName: json['beta_name'] as String?,
      views: json['views'] as int?,
      viewsweek: json['viewsweek'] as int?,
      upvotes: json['upvotes'] as int?,
      downvotes: json['downvotes'] as int?,
      formats: (json['formats'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      treatedAs: json['treated_as'] as String?,
      tcgDate: json['tcg_date'] as String?,
      ocgDate: json['ocg_date'] as String?,
      konamiId: json['konami_id'] as int?,
      mdRarity: json['md_rarity'] as String?,
      hasEffect: json['has_effect'] as int?,
      genesysPoints: json['genesys_points'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (betaName != null) 'beta_name': betaName,
      if (views != null) 'views': views,
      if (viewsweek != null) 'viewsweek': viewsweek,
      if (upvotes != null) 'upvotes': upvotes,
      if (downvotes != null) 'downvotes': downvotes,
      if (formats != null) 'formats': formats,
      if (treatedAs != null) 'treated_as': treatedAs,
      if (tcgDate != null) 'tcg_date': tcgDate,
      if (ocgDate != null) 'ocg_date': ocgDate,
      if (konamiId != null) 'konami_id': konamiId,
      if (mdRarity != null) 'md_rarity': mdRarity,
      if (hasEffect != null) 'has_effect': hasEffect,
      if (genesysPoints != null) 'genesys_points': genesysPoints,
    };
  }
}
