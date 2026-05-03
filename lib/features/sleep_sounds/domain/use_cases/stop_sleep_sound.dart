import '../repositories/sleep_sound_repository.dart';

class StopSleepSound {
  const StopSleepSound(this._repository);

  final SleepSoundRepository _repository;

  Future<void> call() {
    return _repository.stop();
  }
}
