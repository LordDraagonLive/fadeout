abstract interface class CrashReportingService {
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  });
}

class NoopCrashReportingService implements CrashReportingService {
  const NoopCrashReportingService();

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {}
}
