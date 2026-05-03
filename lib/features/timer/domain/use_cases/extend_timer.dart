import '../entities/timer_session.dart';

class ExtendTimer {
  const ExtendTimer();

  TimerSession call(TimerSession current, Duration duration) {
    return current.extend(duration);
  }
}
