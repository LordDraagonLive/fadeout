import '../entities/media_action_result.dart';
import '../repositories/media_control_repository.dart';

class PauseOrStopMedia {
  const PauseOrStopMedia(this._repository);

  final MediaControlRepository _repository;

  Future<MediaActionResult> call({required Duration fadeDuration}) async {
    await _repository.captureCurrentVolume();

    try {
      if (fadeDuration > Duration.zero) {
        await _repository.fadeVolume(fadeDuration);
      }

      final pauseResult = await _repository.pauseCurrentMedia();
      if (pauseResult.succeeded ||
          pauseResult.status == MediaActionStatus.noActiveSession) {
        return pauseResult;
      }

      return _repository.stopCurrentMedia();
    } finally {
      await _repository.restoreVolume();
    }
  }
}
