import 'package:flutter/services.dart';

import '../../domain/entities/timer_session.dart';

class TimerMethodChannel {
  const TimerMethodChannel({
    MethodChannel channel = const MethodChannel('com.helagen.fadeout/timer'),
  }) : _channel = channel;

  final MethodChannel _channel;

  Future<void> startTimer(TimerSession session) {
    return _channel.invokeMethod<void>('startTimer', {
      'totalDurationMillis': session.totalDuration.inMilliseconds,
      'remainingMillis': session.remaining.inMilliseconds,
      'fadeDurationMillis': session.fadeOutConfig.duration.inMilliseconds,
      'fadeEnabled': session.fadeOutConfig.enabled,
    });
  }

  Future<void> pauseTimer() {
    return _channel.invokeMethod<void>('pauseTimer');
  }

  Future<void> resumeTimer() {
    return _channel.invokeMethod<void>('resumeTimer');
  }

  Future<void> cancelTimer() {
    return _channel.invokeMethod<void>('cancelTimer');
  }
}
