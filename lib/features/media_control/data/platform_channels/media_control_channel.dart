import 'package:flutter/services.dart';

import '../../domain/entities/media_action_result.dart';

class MediaControlChannel {
  const MediaControlChannel({
    MethodChannel channel = const MethodChannel(
      'com.helagen.fadeout/media_control',
    ),
  }) : _channel = channel;

  final MethodChannel _channel;

  Future<void> captureCurrentVolume() {
    return _channel.invokeMethod<void>('captureCurrentVolume');
  }

  Future<void> fadeVolume(Duration duration) {
    return _channel.invokeMethod<void>(
      'fadeVolume',
      {'durationMillis': duration.inMilliseconds},
    );
  }

  Future<MediaActionResult> pauseCurrentMedia() async {
    final status = await _channel.invokeMethod<String>('pauseCurrentMedia');
    return _mapStatus(status);
  }

  Future<MediaActionResult> stopCurrentMedia() async {
    final status = await _channel.invokeMethod<String>('stopCurrentMedia');
    return _mapStatus(status);
  }

  Future<void> restoreVolume() {
    return _channel.invokeMethod<void>('restoreVolume');
  }

  MediaActionResult _mapStatus(String? status) {
    return switch (status) {
      'paused' => const MediaActionResult.paused(),
      'stopped' => const MediaActionResult.stopped(),
      'noActiveSession' => const MediaActionResult.noActiveSession(),
      _ => MediaActionResult.failed(status),
    };
  }
}
