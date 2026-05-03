class FadeOutConfig {
  const FadeOutConfig({
    required this.enabled,
    required this.duration,
  });

  factory FadeOutConfig.mvpDefault() {
    return const FadeOutConfig(
      enabled: true,
      duration: Duration(seconds: 60),
    );
  }

  final bool enabled;
  final Duration duration;
}
