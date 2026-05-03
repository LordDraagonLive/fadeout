import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/timer_session.dart';
import '../../domain/use_cases/cancel_timer.dart';
import '../../domain/use_cases/extend_timer.dart';
import '../../domain/use_cases/pause_timer.dart';
import '../../domain/use_cases/resume_timer.dart';
import '../../domain/use_cases/start_timer.dart';

class TimerController extends StateNotifier<TimerSession> {
  TimerController({
    required StartTimer startTimer,
    required PauseTimer pauseTimer,
    required ResumeTimer resumeTimer,
    required CancelTimer cancelTimer,
    required ExtendTimer extendTimer,
  })  : _startTimer = startTimer,
        _pauseTimer = pauseTimer,
        _resumeTimer = resumeTimer,
        _cancelTimer = cancelTimer,
        _extendTimer = extendTimer,
        super(TimerSession.idle());

  final StartTimer _startTimer;
  final PauseTimer _pauseTimer;
  final ResumeTimer _resumeTimer;
  final CancelTimer _cancelTimer;
  final ExtendTimer _extendTimer;

  Future<void> start(Duration duration) async {
    state = await _startTimer(state, duration);
  }

  Future<void> pause() async {
    state = await _pauseTimer(state);
  }

  Future<void> resume() async {
    state = await _resumeTimer(state);
  }

  Future<void> cancel() async {
    state = await _cancelTimer(state);
  }

  void extend(Duration duration) {
    state = _extendTimer(state, duration);
  }

  void tick(Duration elapsed) {
    state = state.tick(elapsed);
  }
}
