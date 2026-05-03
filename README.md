# FadeOut

FadeOut is a HelaGen sleep timer app for mobile media playback.

The product is a system media sleep timer, not an app-specific Spotify,
YouTube, or Netflix integration. Users set a countdown, continue listening or
watching in another app, and FadeOut attempts to pause the currently active
media session when the timer ends.

## MVP Direction

- Flutter app with Android and iOS launch targets.
- Android is the strongest feature platform and primary reliability target.
- iOS is supported with careful platform wording because media control depends
  on iOS and the currently playing app.
- No app-specific integrations for MVP.
- No real backend for MVP.
- Crash reporting is the only observability need for MVP; provider TBD.

## Documentation

- [MVP decisions](docs/mvp-decisions.md)
- [Clean architecture](docs/clean-architecture.md)
- [Implementation plan](docs/implementation-plan.md)
- [Third-party service boundaries](docs/third-party-service-boundaries.md)
- [Development setup](docs/development-setup.md)

## Development

Flutter and Dart must be installed locally before running the app.

```text
flutter pub get
flutter analyze
flutter test
```

The current scaffold intentionally uses no real ad, purchase, subscription, or
crash-reporting vendor SDKs. Those providers should be added later behind the
neutral service boundaries.
