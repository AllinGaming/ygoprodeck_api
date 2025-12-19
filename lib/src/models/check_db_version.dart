/// Database version response.
class CheckDbVersion {
  CheckDbVersion({
    required this.databaseVersion,
    required this.databaseVersionDate,
  });

  /// Database version number.
  final int databaseVersion;

  /// Last updated date.
  final String databaseVersionDate;

  factory CheckDbVersion.fromJson(Map<String, dynamic> json) {
    final rawVersion = json['database_version'];
    final version =
        rawVersion is int ? rawVersion : int.tryParse(rawVersion.toString());
    return CheckDbVersion(
      databaseVersion: version ?? 0,
      databaseVersionDate: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'database_version': databaseVersion,
      'date': databaseVersionDate,
    };
  }
}
