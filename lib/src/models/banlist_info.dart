class BanlistInfo {
  BanlistInfo({
    this.banTcg,
    this.banOcg,
    this.banGoat,
  });

  final String? banTcg;
  final String? banOcg;
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
