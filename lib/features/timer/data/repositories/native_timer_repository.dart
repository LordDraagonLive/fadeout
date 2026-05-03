import '../../domain/entities/timer_session.dart';
import '../../domain/repositories/timer_repository.dart';
import '../platform_channels/timer_method_channel.dart';

class NativeTimerRepository implements TimerRepository {
  const NativeTimerRepository(this._channel);

  final TimerMethodChannel _channel;

  @override
  Future<void> cancelForegroundTimer() {
    return _channel.cancelTimer();
  }

  @override
  Future<void> pauseForegroundTimer() {
    return _channel.pauseTimer();
  }

  @override
  Future<void> resumeForegroundTimer() {
    return _channel.resumeTimer();
  }

  @override
  Future<void> startForegroundTimer(TimerSession session) {
    return _channel.startTimer(session);
  }
}
