enum SleepSoundId {
  rain,
  ocean,
  brownNoise,
}

class SleepSound {
  const SleepSound({
    required this.id,
    required this.name,
    required this.assetPath,
  });

  final SleepSoundId id;
  final String name;
  final String assetPath;
}
