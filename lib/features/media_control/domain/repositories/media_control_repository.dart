import '../entities/media_action_result.dart';

abstract interface class MediaControlRepository {
  Future<void> captureCurrentVolume();
  Future<void> fadeVolume(Duration duration);
  Future<MediaActionResult> pauseCurrentMedia();
  Future<MediaActionResult> stopCurrentMedia();
  Future<void> restoreVolume();
}
