# Development Setup

## Flutter SDK

The project is configured to use:

```text
C:\flutter
```

The executable path is:

```text
C:\flutter\bin
```

If `flutter doctor -v` says `flutter` or `dart` resolves somewhere else, move
`C:\flutter\bin` to the front of the Windows user PATH and restart Cursor or the
terminal.

Current known stale path to remove or move below `C:\flutter\bin`:

```text
C:\Users\bca\flutter\flutter\bin
```

## Android SDK

Android builds require an Android SDK. `flutter doctor -v` currently reports:

```text
Unable to locate Android SDK.
```

Install Android Studio, then install:

```text
Android SDK Platform
Android SDK Command-line Tools
Android SDK Build-Tools
Android SDK Platform-Tools
```

After installation, either set `ANDROID_HOME` to the SDK path or run:

```text
flutter config --android-sdk <path-to-android-sdk>
```

The common Windows SDK path is:

```text
C:\Users\bca\AppData\Local\Android\Sdk
```

## Project Checks

```text
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

The pub.dev advisory decoding message for `shared_preferences_android` is not a
dependency resolution failure as long as the command ends with `Got dependencies!`.
