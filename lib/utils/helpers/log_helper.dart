import 'dart:developer' as developer;

class LogHelper {
  static void error(String tag, dynamic error, [StackTrace? stackTrace]) {
    developer.log(
      '🔴 ERROR [$tag]: $error',
      name: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void success(String tag, String message) {
    developer.log('🟢 SUCCESS [$tag]: $message', name: tag);
  }

  static void info(String tag, String message) {
    developer.log('🔵 INFO [$tag]: $message', name: tag);
  }
}
