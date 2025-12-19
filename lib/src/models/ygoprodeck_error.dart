/// Exception thrown for API errors and HTTP failures.
class YgoProDeckApiException implements Exception {
  YgoProDeckApiException({
    required this.message,
    required this.statusCode,
    required this.url,
  });

  /// Error message returned by the API.
  final String message;

  /// HTTP status code.
  final int statusCode;

  /// Request URL.
  final Uri url;

  @override
  String toString() {
    return 'YgoProDeckApiException(statusCode: $statusCode, message: $message, url: $url)';
  }
}
