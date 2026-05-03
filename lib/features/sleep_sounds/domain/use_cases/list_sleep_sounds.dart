import '../entities/sleep_sound.dart';
import '../repositories/sleep_sound_repository.dart';

class ListSleepSounds {
  const ListSleepSounds(this._repository);

  final SleepSoundRepository _repository;

  List<SleepSound> call() {
    return _repository.availableSounds();
  }
}
