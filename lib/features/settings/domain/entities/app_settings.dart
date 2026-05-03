class AppSettings {
  const AppSettings({
    required this.defaultTimer,
    required this.fadeOutEnabled,
    required this.themeMode,
    required this.onboardingCompleted,
    required this.showAndroidSetupGuide,
  });

  factory AppSettings.defaults() {
    return const AppSettings(
      defaultTimer: Duration(minutes: 30),
      fadeOutEnabled: true,
      themeMode: AppThemeMode.dark,
      onboardingCompleted: false,
      showAndroidSetupGuide: true,
    );
  }

  final Duration defaultTimer;
  final bool fadeOutEnabled;
  final AppThemeMode themeMode;
  final bool onboardingCompleted;
  final bool showAndroidSetupGuide;

  AppSettings copyWith({
    Duration? defaultTimer,
    bool? fadeOutEnabled,
    AppThemeMode? themeMode,
    bool? onboardingCompleted,
    bool? showAndroidSetupGuide,
  }) {
    return AppSettings(
      defaultTimer: defaultTimer ?? this.defaultTimer,
      fadeOutEnabled: fadeOutEnabled ?? this.fadeOutEnabled,
      themeMode: themeMode ?? this.themeMode,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      showAndroidSetupGuide:
          showAndroidSetupGuide ?? this.showAndroidSetupGuide,
    );
  }
}

enum AppThemeMode {
  dark,
  system,
}
