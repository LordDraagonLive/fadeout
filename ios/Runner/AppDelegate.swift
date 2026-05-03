import AVFoundation
import Flutter
import MediaPlayer
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var capturedVolume: Float?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    registerFadeOutChannels()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  private func registerFadeOutChannels() {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return
    }

    let messenger = controller.binaryMessenger

    FlutterMethodChannel(
      name: "com.helagen.fadeout/media_control",
      binaryMessenger: messenger
    ).setMethodCallHandler { [weak self] call, result in
      self?.handleMediaControlCall(call, result: result)
    }

    FlutterMethodChannel(
      name: "com.helagen.fadeout/timer",
      binaryMessenger: messenger
    ).setMethodCallHandler { call, result in
      switch call.method {
      case "startTimer", "pauseTimer", "resumeTimer", "cancelTimer":
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    FlutterMethodChannel(
      name: "com.helagen.fadeout/permissions",
      binaryMessenger: messenger
    ).setMethodCallHandler { call, result in
      switch call.method {
      case "isIgnoringBatteryOptimizations":
        result(true)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    FlutterMethodChannel(
      name: "com.helagen.fadeout/notifications",
      binaryMessenger: messenger
    ).setMethodCallHandler { call, result in
      switch call.method {
      case "ensureTimerNotificationChannel":
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private func handleMediaControlCall(_ call: FlutterMethodCall, result: FlutterResult) {
    switch call.method {
    case "captureCurrentVolume":
      capturedVolume = AVAudioSession.sharedInstance().outputVolume
      result(nil)
    case "fadeVolume":
      result(nil)
    case "pauseCurrentMedia":
      MPMusicPlayerController.systemMusicPlayer.pause()
      result("paused")
    case "stopCurrentMedia":
      MPMusicPlayerController.systemMusicPlayer.stop()
      result("stopped")
    case "restoreVolume":
      capturedVolume = nil
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
