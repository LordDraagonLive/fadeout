import '../entities/timer_session.dart';
import '../repositories/timer_repository.dart';

class CancelTimer {
  const CancelTimer(this._repository);

  final TimerRepository _repository;

  Future<TimerSession> call(TimerSession current) async {
    final next = current.cancel();
    await _repository.cancelForegroundTimer();
    return next;
  }
}
