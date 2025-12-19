import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

void main() {
  test('RetryPolicy retries on 5xx', () {
    final policy = RetryPolicy(maxAttempts: 3, jitter: false);
    final response = http.Response('error', 500);

    expect(policy.shouldRetryResponse(response), isTrue);
  });

  test('RetryPolicy does not retry on 200', () {
    final policy = RetryPolicy(maxAttempts: 3, jitter: false);
    final response = http.Response('ok', 200);

    expect(policy.shouldRetryResponse(response), isFalse);
  });

  test('RetryPolicy delay increases with attempts', () {
    final policy = RetryPolicy(
      maxAttempts: 3,
      jitter: false,
      baseDelay: const Duration(milliseconds: 100),
      maxDelay: const Duration(seconds: 1),
    );

    final first = policy.delayForAttempt(1);
    final second = policy.delayForAttempt(2);
    final third = policy.delayForAttempt(3);

    expect(first.inMilliseconds, 100);
    expect(second.inMilliseconds, 200);
    expect(third.inMilliseconds, 400);
  });
}
