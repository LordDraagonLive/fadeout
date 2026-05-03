import '../entities/sleep_sound.dart';
import '../repositories/sleep_sound_repository.dart';

class PlaySleepSound {
  const PlaySleepSound(this._repository);

  final SleepSoundRepository _repository;

  Future<void> call(SleepSoundId id) {
    return _repository.play(id);
  }
}
