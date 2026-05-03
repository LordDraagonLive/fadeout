import 'fade_out_config.dart';
import 'timer_status.dart';

class TimerSession {
  const TimerSession({
    required this.totalDuration,
    required this.remaining,
    required this.status,
    required this.fadeOutConfig,
  });

  factory TimerSession.idle({
    Duration defaultDuration = const Duration(minutes: 30),
  }) {
    return TimerSession(
      totalDuration: defaultDuration,
      remaining: defaultDuration,
      status: TimerStatus.idle,
      fadeOutConfig: FadeOutConfig.mvpDefault(),
    );
  }

  final Duration totalDuration;
  final Duration remaining;
  final TimerStatus status;
  final FadeOutConfig fadeOutConfig;

  bool get isActive =>
      status == TimerStatus.running || status == TimerStatus.paused;
  bool get shouldFade =>
      fadeOutConfig.enabled && remaining <= fadeOutConfig.duration;

  TimerSession start(Duration duration) {
    return copyWith(
      totalDuration: duration,
      remaining: duration,
      status: TimerStatus.running,
    );
  }

  TimerSession pause() {
    if (status != TimerStatus.running) {
      return this;
    }

    return copyWith(status: TimerStatus.paused);
  }

  TimerSession resume() {
    if (status != TimerStatus.paused) {
      return this;
    }

    return copyWith(status: TimerStatus.running);
  }

  TimerSession cancel() {
    return copyWith(status: TimerStatus.cancelled);
  }

  TimerSession extend(Duration duration) {
    if (!isActive) {
      return this;
    }

    return copyWith(remaining: remaining + duration);
  }

  TimerSession tick(Duration elapsed) {
    if (status != TimerStatus.running || elapsed <= Duration.zero) {
      return this;
    }

    final nextRemaining = remaining - elapsed;
    if (nextRemaining <= Duration.zero) {
      return copyWith(
        remaining: Duration.zero,
        status: TimerStatus.completed,
      );
    }

    return copyWith(remaining: nextRemaining);
  }

  TimerSession copyWith({
    Duration? totalDuration,
    Duration? remaining,
    TimerStatus? status,
    FadeOutConfig? fadeOutConfig,
  }) {
    return TimerSession(
      totalDuration: totalDuration ?? this.totalDuration,
      remaining: remaining ?? this.remaining,
      status: status ?? this.status,
      fadeOutConfig: fadeOutConfig ?? this.fadeOutConfig,
    );
  }
}
