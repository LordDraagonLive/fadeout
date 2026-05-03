# Clean Architecture

FadeOut should keep business rules independent from Flutter widgets, native
platform APIs, persistence, ads, analytics, and purchase SDKs.

The core rule is:

> UI depends inward. Native and third-party implementations stay at the edges.

## Dependency Direction

```text
Presentation
   -> Application
      -> Domain

Data
   -> Domain

Platform Adapters
   -> Domain
   -> Application contracts
```

The domain layer must not import Flutter, Android, iOS, crash reporting,
purchase, analytics, or ad SDKs.

## Recommended Flutter Layout

```text
lib/
  main.dart
  app/
    fadeout_app.dart
    router/
    theme/
    di/
  core/
    constants/
    errors/
    result/
    time/
    logging/
  features/
    timer/
      domain/
        entities/
        repositories/
        services/
        use_cases/
      application/
        state/
        controllers/
        coordinators/
      data/
        models/
        repositories/
        sources/
      presentation/
        screens/
        widgets/
    media_control/
      domain/
        entities/
        repositories/
        use_cases/
      application/
      data/
        platform_channels/
      presentation/
    sleep_sounds/
      domain/
      application/
      data/
      presentation/
    onboarding/
      domain/
      application/
      data/
      presentation/
    settings/
      domain/
      application/
      data/
      presentation/
    monetization/
      domain/
      application/
      data/
      presentation/
```

Native code:

```text
android/
  app/src/main/kotlin/.../fadeout/
    MainActivity.kt
    timer/
      FadeOutTimerService.kt
      TimerNotificationController.kt
    media/
      MediaSessionController.kt
      VolumeFadeController.kt
    permissions/
      BatteryOptimizationHelper.kt
    channels/
      TimerMethodChannel.kt
      MediaControlMethodChannel.kt

ios/
  Runner/
    AppDelegate.swift
    Timer/
    MediaControl/
    SleepSounds/
    Channels/
```

## Feature Boundaries

### Timer

Owns countdown state and timer behavior.

Domain examples:

- `TimerDuration`
- `TimerSession`
- `TimerStatus`
- `FadeOutConfig`
- `StartTimer`
- `PauseTimer`
- `ResumeTimer`
- `CancelTimer`
- `ExtendTimer`

The timer feature should request media actions through a domain contract instead
of calling platform channels directly.

### Media Control

Owns "pause current media", "stop current media", and volume fade behavior.

Domain examples:

- `MediaControlCapability`
- `MediaActionResult`
- `PauseCurrentMedia`
- `StopCurrentMedia`
- `FadeVolume`
- `RestoreVolume`

Platform-specific details remain in Android Kotlin and iOS Swift adapters.

### Sleep Sounds

Owns built-in audio playback for rain, ocean, and brown noise.

Domain examples:

- `SleepSound`
- `SleepSoundPlaybackState`
- `PlaySleepSound`
- `FadeOutSleepSound`
- `StopSleepSound`

### Settings

Owns user preferences.

MVP settings:

- Default timer duration.
- Fade-out enabled.
- Restore volume enabled internally, fixed to true for MVP.
- Theme.
- Android setup guide visibility.
- Pro status cache.

### Monetization

Owns entitlement state and upgrade UI.

MVP monetization:

- Free user.
- Pro lifetime unlock.
- Ads enabled only when user has no Pro/subscription entitlement.

Subscription concepts can exist in the domain as future-ready entitlement types,
but subscription purchase flows should not be built for MVP.

## Platform Channels

Use narrow method channels. Avoid one generic "native" channel.

Recommended channels:

```text
com.helagen.fadeout/timer
com.helagen.fadeout/media_control
com.helagen.fadeout/permissions
com.helagen.fadeout/notifications
```

The Flutter side should define interfaces first, then implement them through
platform channel adapters.

Example:

```text
TimerController
  -> StartTimer use case
    -> TimerRepository contract
      -> NativeTimerRepository
        -> TimerMethodChannel
```

## State Management

Use one consistent state management approach. Recommended:

```text
Riverpod
```

Reasons:

- Works well with feature-based Clean Architecture.
- Keeps dependency injection simple.
- Makes controller state testable.
- Avoids widget-heavy business logic.

If the team prefers Bloc, it is also a valid option. Do not mix Riverpod and Bloc
for primary feature state.

## Persistence

Recommended MVP storage:

```text
SharedPreferences
```

Use it for:

- Last selected timer.
- One saved default timer.
- Fade setting.
- Onboarding completion.
- Theme.
- Cached entitlement flags.

Avoid SQLite/Drift until routines, history, or sleep insights require structured
local data.

## Error Handling

Use explicit result types for recoverable failures.

Examples:

- Permission missing.
- No active media session.
- Pause failed and stop succeeded.
- Pause and stop both failed.
- Volume restore failed.

UI should show calm, non-technical messages:

- "FadeOut could not find active media to pause."
- "Media control depends on the currently playing app."
- "Timer finished. Volume restored."

## Testing Strategy

MVP test priorities:

- Domain use cases for timer state transitions.
- Fade timing and restore-volume decision logic.
- Media action fallback: pause first, stop second.
- Settings persistence.
- Presentation controller state.

Native Android instrumentation can come after the first working bridge, but the
Kotlin media controller should be kept small enough to test manually early.

## Implementation Rules

- Widgets should not call platform channels directly.
- Controllers should not know Android or iOS APIs.
- Domain should not know Flutter.
- Ads should never appear on the active timer screen.
- Timer completion must always attempt volume restoration after fade, even if
  media pause/stop fails.
- iOS copy must use best-effort wording.
