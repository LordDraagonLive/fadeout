abstract interface class AppLogger {
  void debug(String message);
  void warning(String message, [Object? error, StackTrace? stackTrace]);
}

class NoopAppLogger implements AppLogger {
  const NoopAppLogger();

  @override
  void debug(String message) {}

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {}
}
