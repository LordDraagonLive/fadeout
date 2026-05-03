# FadeOut Implementation Plan

This plan turns the locked MVP decisions into a clean, user-friendly Flutter
codebase. The goal is to keep the app easy to extend without hiding simple
features behind unnecessary abstraction.

## Product Baseline

FadeOut is a HelaGen product that launches on Android and iOS together, with
Android as the strongest platform for the core system media timer behavior.

MVP behavior:

- User selects a preset or custom timer duration.
- App runs a reliable countdown.
- Final 60 seconds fades audio down.
- Timer completion pauses the active media session.
- If pause fails, the app tries stop.
- Original volume is always restored.
- Ads appear only on home/settings for users without Pro or subscription.
- Active timer screen is always calm and ad-free.
- Subscription is reserved for phase 2 or 3.

## Architecture Style

Use feature-first Clean Architecture:

```text
lib/features/<feature>/
  domain/
  application/
  data/
  presentation/
```

This keeps each feature understandable to a developer opening the project for
the first time. Each folder answers a simple question:

| Folder | Question it answers |
| --- | --- |
| domain | What are the business rules? |
| application | How do rules turn into app behavior and state? |
| data | Where does data or platform behavior come from? |
| presentation | What does the user see and interact with? |

## Dependency Rules

Allowed direction:

```text
presentation -> application -> domain
data -> domain
```

Forbidden:

- Domain importing Flutter.
- Domain importing crash, purchase, ad, analytics, or platform SDKs.
- Widgets calling Android/iOS method channels directly.
- Native media code living inside presentation controllers.
- Ads rendering on the active timer screen.

## MVP Feature Modules

### timer

Owns the countdown and timer session.

Suggested files:

```text
features/timer/domain/entities/timer_duration.dart
features/timer/domain/entities/timer_session.dart
features/timer/domain/entities/timer_status.dart
features/timer/domain/use_cases/start_timer.dart
features/timer/domain/use_cases/pause_timer.dart
features/timer/domain/use_cases/resume_timer.dart
features/timer/domain/use_cases/cancel_timer.dart
features/timer/domain/use_cases/extend_timer.dart
features/timer/application/controllers/timer_controller.dart
features/timer/presentation/screens/home_timer_screen.dart
features/timer/presentation/screens/active_timer_screen.dart
```

The timer feature coordinates media actions through interfaces. It should not
know how Android media sessions or iOS media controls work.

### media_control

Owns system media pause/stop and volume behavior.

Suggested files:

```text
features/media_control/domain/entities/media_action_result.dart
features/media_control/domain/repositories/media_control_repository.dart
features/media_control/domain/use_cases/pause_or_stop_media.dart
features/media_control/domain/use_cases/fade_volume.dart
features/media_control/domain/use_cases/restore_volume.dart
features/media_control/data/platform_channels/media_control_channel.dart
features/media_control/data/repositories/native_media_control_repository.dart
```

Core rule:

```text
pause -> if failed, stop -> always restore volume
```

### sleep_sounds

Owns the 3 built-in MVP sounds.

MVP sounds:

- Rain.
- Ocean.
- Brown noise.

Suggested files:

```text
features/sleep_sounds/domain/entities/sleep_sound.dart
features/sleep_sounds/domain/repositories/sleep_sound_repository.dart
features/sleep_sounds/domain/use_cases/play_sleep_sound.dart
features/sleep_sounds/domain/use_cases/fade_sleep_sound.dart
features/sleep_sounds/domain/use_cases/stop_sleep_sound.dart
features/sleep_sounds/presentation/widgets/sleep_sound_picker.dart
```

### settings

Owns preferences and setup choices.

MVP settings:

- Default timer duration.
- Basic fade-out enabled.
- Theme.
- Onboarding completed.
- Android setup guide visibility.
- Cached Pro entitlement.

Volume restore is always on for MVP, so it can be represented as a fixed domain
policy instead of a visible setting.

### monetization

Owns entitlement state, ads eligibility, and upgrade messaging.

MVP rules:

- Free users can use the core timer.
- Pro lifetime unlock costs USD 5.99.
- Pro removes ads and unlocks advanced fade settings.
- Subscription is modeled as a future entitlement but not sold in MVP.
- Ads only render on home/settings when the user has no paid entitlement.

### onboarding

Owns first-run explanation and platform setup guidance.

MVP content:

- FadeOut is a system media sleep timer, not a Spotify/YouTube/Netflix-specific
  integration.
- Android users can optionally review battery optimization guidance.
- iOS media control depends on iOS and the currently playing app.

## Native Boundaries

Android owns reliable background execution and media-session control:

```text
android/app/src/main/kotlin/.../fadeout/
  timer/FadeOutTimerService.kt
  timer/TimerNotificationController.kt
  media/MediaSessionController.kt
  media/VolumeFadeController.kt
  permissions/BatteryOptimizationHelper.kt
  channels/TimerMethodChannel.kt
  channels/MediaControlMethodChannel.kt
```

iOS owns best-effort controls and in-app audio behavior:

```text
ios/Runner/
  Timer/
  MediaControl/
  SleepSounds/
  Channels/
```

Flutter should talk to native code through narrow channels:

```text
com.helagen.fadeout/timer
com.helagen.fadeout/media_control
com.helagen.fadeout/permissions
com.helagen.fadeout/notifications
```

## Suggested Build Order

1. Create Flutter scaffold and package identity.
2. Add theme, routing, and dependency injection.
3. Implement timer domain entities and use cases.
4. Build home and active timer UI.
5. Add SharedPreferences-backed settings.
6. Add Android foreground service and notification bridge.
7. Add Android media control and volume fade bridge.
8. Add iOS local timer behavior and best-effort media control.
9. Add 3 bundled sleep sounds.
10. Add crash reporting only if needed, behind the neutral service boundary.
11. Add Pro entitlement shape and ad placement rules.
12. Test timer completion, pause fallback, and volume restoration.

Third-party SDKs should be added only after the provider decision is made. Until
then, keep calls behind the blank service boundaries in
`third-party-service-boundaries.md`.

## Testing Priorities

Write tests first around behavior that would be painful to regress:

- Preset and custom timer duration validation.
- Start, pause, resume, cancel, and extend state transitions.
- 60-second fade default.
- Pause failure falling back to stop.
- Volume restore always being attempted.
- Ads hidden during active timer.
- Pro entitlement removing ads.
- iOS copy using safe wording.
