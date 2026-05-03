import '../../domain/entities/timer_session.dart';
import '../../domain/repositories/timer_repository.dart';

class LocalTimerRepository implements TimerRepository {
  TimerSession? lastStartedSession;
  bool isPaused = false;

  @override
  Future<void> startForegroundTimer(TimerSession session) async {
    lastStartedSession = session;
    isPaused = false;
  }

  @override
  Future<void> pauseForegroundTimer() async {
    isPaused = true;
  }

  @override
  Future<void> resumeForegroundTimer() async {
    isPaused = false;
  }

  @override
  Future<void> cancelForegroundTimer() async {
    lastStartedSession = null;
    isPaused = false;
  }
}
