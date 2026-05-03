import '../../domain/entities/sleep_sound.dart';
import '../../domain/repositories/sleep_sound_repository.dart';

class LocalSleepSoundRepository implements SleepSoundRepository {
  SleepSoundId? currentSound;

  @override
  List<SleepSound> availableSounds() {
    return const [
      SleepSound(
        id: SleepSoundId.rain,
        name: 'Rain',
        assetPath: 'assets/audio/rain.mp3',
      ),
      SleepSound(
        id: SleepSoundId.ocean,
        name: 'Ocean',
        assetPath: 'assets/audio/ocean.mp3',
      ),
      SleepSound(
        id: SleepSoundId.brownNoise,
        name: 'Brown noise',
        assetPath: 'assets/audio/brown_noise.mp3',
      ),
    ];
  }

  @override
  Future<void> fadeOut(Duration duration) async {}

  @override
  Future<void> play(SleepSoundId id) async {
    currentSound = id;
  }

  @override
  Future<void> stop() async {
    currentSound = null;
  }
}
