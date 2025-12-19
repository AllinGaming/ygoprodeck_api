class MetaInfo {
  MetaInfo({
    required this.currentRows,
    required this.totalRows,
    required this.rowsRemaining,
    required this.totalPages,
    required this.pagesRemaining,
    this.nextPage,
    this.nextPageOffset,
  });

  final int currentRows;
  final int totalRows;
  final int rowsRemaining;
  final int totalPages;
  final int pagesRemaining;
  final String? nextPage;
  final int? nextPageOffset;

  factory MetaInfo.fromJson(Map<String, dynamic> json) {
    return MetaInfo(
      currentRows: json['current_rows'] as int,
      totalRows: json['total_rows'] as int,
      rowsRemaining: json['rows_remaining'] as int,
      totalPages: json['total_pages'] as int,
      pagesRemaining: json['pages_remaining'] as int,
      nextPage: json['next_page'] as String?,
      nextPageOffset: json['next_page_offset'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_rows': currentRows,
      'total_rows': totalRows,
      'rows_remaining': rowsRemaining,
      'total_pages': totalPages,
      'pages_remaining': pagesRemaining,
      if (nextPage != null) 'next_page': nextPage,
      if (nextPageOffset != null) 'next_page_offset': nextPageOffset,
    };
  }
}
