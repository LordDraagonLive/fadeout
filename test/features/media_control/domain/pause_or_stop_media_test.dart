import 'package:fadeout/features/media_control/data/repositories/fake_media_control_repository.dart';
import 'package:fadeout/features/media_control/domain/entities/media_action_result.dart';
import 'package:fadeout/features/media_control/domain/use_cases/pause_or_stop_media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tries stop when pause fails', () async {
    final repository = FakeMediaControlRepository()
      ..pauseResult = const MediaActionResult.failed()
      ..stopResult = const MediaActionResult.stopped();

    final result = await PauseOrStopMedia(repository)(
      fadeDuration: const Duration(seconds: 60),
    );

    expect(result.status, MediaActionStatus.stopped);
    expect(repository.capturedVolume, true);
    expect(repository.fadedVolume, true);
    expect(repository.restoredVolume, true);
  });

  test('restores volume even when no active media session is found', () async {
    final repository = FakeMediaControlRepository()
      ..pauseResult = const MediaActionResult.noActiveSession();

    final result = await PauseOrStopMedia(repository)(
      fadeDuration: const Duration(seconds: 60),
    );

    expect(result.status, MediaActionStatus.noActiveSession);
    expect(repository.restoredVolume, true);
  });
}
