class TimerFormatter {
  const TimerFormatter._();

  static String compact(Duration duration) {
    final totalSeconds = duration.inSeconds;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '$hours:${_two(minutes)}:${_two(seconds)}';
    }

    return '${_two(minutes)}:${_two(seconds)}';
  }

  static String _two(int value) {
    return value.toString().padLeft(2, '0');
  }
}
