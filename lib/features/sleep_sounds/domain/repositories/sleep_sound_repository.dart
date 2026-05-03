import '../entities/sleep_sound.dart';

abstract interface class SleepSoundRepository {
  List<SleepSound> availableSounds();
  Future<void> play(SleepSoundId id);
  Future<void> fadeOut(Duration duration);
  Future<void> stop();
}
