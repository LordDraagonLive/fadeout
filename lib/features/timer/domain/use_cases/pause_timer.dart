import '../entities/timer_session.dart';
import '../repositories/timer_repository.dart';

class PauseTimer {
  const PauseTimer(this._repository);

  final TimerRepository _repository;

  Future<TimerSession> call(TimerSession current) async {
    final next = current.pause();
    await _repository.pauseForegroundTimer();
    return next;
  }
}
