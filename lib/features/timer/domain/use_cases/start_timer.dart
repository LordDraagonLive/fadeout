import '../entities/timer_session.dart';
import '../repositories/timer_repository.dart';

class StartTimer {
  const StartTimer(this._repository);

  final TimerRepository _repository;

  Future<TimerSession> call(TimerSession current, Duration duration) async {
    final next = current.start(duration);
    await _repository.startForegroundTimer(next);
    return next;
  }
}
