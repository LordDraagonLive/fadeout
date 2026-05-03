import '../entities/timer_session.dart';
import '../repositories/timer_repository.dart';

class ResumeTimer {
  const ResumeTimer(this._repository);

  final TimerRepository _repository;

  Future<TimerSession> call(TimerSession current) async {
    final next = current.resume();
    await _repository.resumeForegroundTimer();
    return next;
  }
}
