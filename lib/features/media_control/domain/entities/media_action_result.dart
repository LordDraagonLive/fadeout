enum MediaActionStatus {
  paused,
  stopped,
  noActiveSession,
  failed,
}

class MediaActionResult {
  const MediaActionResult({
    required this.status,
    this.message,
  });

  const MediaActionResult.paused()
      : status = MediaActionStatus.paused,
        message = null;

  const MediaActionResult.stopped()
      : status = MediaActionStatus.stopped,
        message = null;

  const MediaActionResult.noActiveSession()
      : status = MediaActionStatus.noActiveSession,
        message = 'No active media session was found.';

  const MediaActionResult.failed([this.message])
      : status = MediaActionStatus.failed;

  final MediaActionStatus status;
  final String? message;

  bool get succeeded {
    return status == MediaActionStatus.paused ||
        status == MediaActionStatus.stopped;
  }
}
