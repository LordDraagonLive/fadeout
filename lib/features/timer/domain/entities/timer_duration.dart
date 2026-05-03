class TimerDuration {
  const TimerDuration._(this.value);

  factory TimerDuration.fromMinutes(int minutes) {
    if (minutes <= 0) {
      throw ArgumentError.value(minutes, 'minutes', 'Must be greater than 0');
    }

    return TimerDuration._(Duration(minutes: minutes));
  }

  factory TimerDuration.custom(Duration duration) {
    if (duration.inSeconds <= 0) {
      throw ArgumentError.value(duration, 'duration', 'Must be greater than 0');
    }

    return TimerDuration._(duration);
  }

  final Duration value;

  int get inMinutes => value.inMinutes;
  int get inSeconds => value.inSeconds;
}
