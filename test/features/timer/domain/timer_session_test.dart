import 'package:fadeout/features/timer/domain/entities/timer_session.dart';
import 'package:fadeout/features/timer/domain/entities/timer_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('starts with the selected duration', () {
    final session = TimerSession.idle().start(const Duration(minutes: 45));

    expect(session.status, TimerStatus.running);
    expect(session.totalDuration, const Duration(minutes: 45));
    expect(session.remaining, const Duration(minutes: 45));
  });

  test('marks session completed when remaining time reaches zero', () {
    final session = TimerSession.idle()
        .start(const Duration(minutes: 1))
        .tick(const Duration(minutes: 1));

    expect(session.status, TimerStatus.completed);
    expect(session.remaining, Duration.zero);
  });

  test('enters fade window during final 60 seconds', () {
    final session = TimerSession.idle()
        .start(const Duration(minutes: 5))
        .tick(const Duration(minutes: 4));

    expect(session.shouldFade, true);
  });
}
