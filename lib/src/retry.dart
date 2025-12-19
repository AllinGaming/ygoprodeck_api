import 'dart:math';

import 'package:http/http.dart' as http;

class RetryPolicy {
  RetryPolicy({
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 2),
    this.jitter = true,
    Set<int>? retryStatusCodes,
  }) : _retryStatusCodes = retryStatusCodes ?? _defaultRetryStatusCodes;

  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;
  final bool jitter;
  final Set<int> _retryStatusCodes;

  static final Set<int> _defaultRetryStatusCodes = {
    500,
    502,
    503,
    504,
  };

  bool shouldRetryResponse(http.Response response) {
    return _retryStatusCodes.contains(response.statusCode);
  }

  bool shouldRetryException(Exception _) {
    return true;
  }

  Duration delayForAttempt(int attempt) {
    final factor = pow(2, attempt - 1).toInt();
    var delayMs = baseDelay.inMilliseconds * factor;
    if (delayMs > maxDelay.inMilliseconds) {
      delayMs = maxDelay.inMilliseconds;
    }
    if (jitter) {
      final rand = Random();
      delayMs = rand.nextInt(delayMs + 1);
    }
    return Duration(milliseconds: delayMs);
  }
}
