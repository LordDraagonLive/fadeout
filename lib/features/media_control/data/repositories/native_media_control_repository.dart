import '../../domain/entities/media_action_result.dart';
import '../../domain/repositories/media_control_repository.dart';
import '../platform_channels/media_control_channel.dart';

class NativeMediaControlRepository implements MediaControlRepository {
  const NativeMediaControlRepository(this._channel);

  final MediaControlChannel _channel;

  @override
  Future<void> captureCurrentVolume() {
    return _channel.captureCurrentVolume();
  }

  @override
  Future<void> fadeVolume(Duration duration) {
    return _channel.fadeVolume(duration);
  }

  @override
  Future<MediaActionResult> pauseCurrentMedia() {
    return _channel.pauseCurrentMedia();
  }

  @override
  Future<void> restoreVolume() {
    return _channel.restoreVolume();
  }

  @override
  Future<MediaActionResult> stopCurrentMedia() {
    return _channel.stopCurrentMedia();
  }
}
