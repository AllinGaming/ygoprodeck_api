class YgoProDeckApiException implements Exception {
  YgoProDeckApiException({
    required this.message,
    required this.statusCode,
    required this.url,
  });

  final String message;
  final int statusCode;
  final Uri url;

  @override
  String toString() {
    return 'YgoProDeckApiException(statusCode: $statusCode, message: $message, url: $url)';
  }
}
