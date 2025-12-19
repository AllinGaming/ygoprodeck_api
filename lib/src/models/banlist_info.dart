/// Banlist status for a card across formats.
class BanlistInfo {
  BanlistInfo({
    this.banTcg,
    this.banOcg,
    this.banGoat,
  });

  /// TCG ban status.
  final String? banTcg;

  /// OCG ban status.
  final String? banOcg;

  /// GOAT format ban status.
  final String? banGoat;

  factory BanlistInfo.fromJson(Map<String, dynamic> json) {
    return BanlistInfo(
      banTcg: json['ban_tcg'] as String?,
      banOcg: json['ban_ocg'] as String?,
      banGoat: json['ban_goat'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (banTcg != null) 'ban_tcg': banTcg,
      if (banOcg != null) 'ban_ocg': banOcg,
      if (banGoat != null) 'ban_goat': banGoat,
    };
  }
}
