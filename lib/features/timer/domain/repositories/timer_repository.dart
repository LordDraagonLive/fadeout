import '../entities/timer_session.dart';

abstract interface class TimerRepository {
  Future<void> startForegroundTimer(TimerSession session);
  Future<void> pauseForegroundTimer();
  Future<void> resumeForegroundTimer();
  Future<void> cancelForegroundTimer();
}
