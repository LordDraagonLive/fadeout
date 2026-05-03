import '../../domain/entities/media_action_result.dart';
import '../../domain/repositories/media_control_repository.dart';

class FakeMediaControlRepository implements MediaControlRepository {
  bool capturedVolume = false;
  bool fadedVolume = false;
  bool restoredVolume = false;
  MediaActionResult pauseResult = const MediaActionResult.paused();
  MediaActionResult stopResult = const MediaActionResult.stopped();

  @override
  Future<void> captureCurrentVolume() async {
    capturedVolume = true;
  }

  @override
  Future<void> fadeVolume(Duration duration) async {
    fadedVolume = duration > Duration.zero;
  }

  @override
  Future<MediaActionResult> pauseCurrentMedia() async {
    return pauseResult;
  }

  @override
  Future<void> restoreVolume() async {
    restoredVolume = true;
  }

  @override
  Future<MediaActionResult> stopCurrentMedia() async {
    return stopResult;
  }
}
