import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/logging/app_logger.dart';
import '../../core/services/crash_reporting_service.dart';
import '../../features/media_control/data/platform_channels/media_control_channel.dart';
import '../../features/media_control/data/repositories/native_media_control_repository.dart';
import '../../features/media_control/domain/repositories/media_control_repository.dart';
import '../../features/media_control/domain/use_cases/pause_or_stop_media.dart';
import '../../features/monetization/data/repositories/local_entitlement_repository.dart';
import '../../features/monetization/domain/entities/entitlement.dart';
import '../../features/monetization/domain/repositories/ad_service.dart';
import '../../features/monetization/domain/repositories/entitlement_repository.dart';
import '../../features/monetization/domain/repositories/purchase_service.dart';
import '../../features/monetization/domain/services/ad_visibility_policy.dart';
import '../../features/settings/data/repositories/memory_settings_repository.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/sleep_sounds/data/repositories/local_sleep_sound_repository.dart';
import '../../features/sleep_sounds/domain/repositories/sleep_sound_repository.dart';
import '../../features/sleep_sounds/domain/use_cases/list_sleep_sounds.dart';
import '../../features/timer/application/controllers/timer_controller.dart';
import '../../features/timer/data/platform_channels/timer_method_channel.dart';
import '../../features/timer/data/repositories/native_timer_repository.dart';
import '../../features/timer/domain/entities/timer_session.dart';
import '../../features/timer/domain/repositories/timer_repository.dart';
import '../../features/timer/domain/use_cases/cancel_timer.dart';
import '../../features/timer/domain/use_cases/extend_timer.dart';
import '../../features/timer/domain/use_cases/pause_timer.dart';
import '../../features/timer/domain/use_cases/resume_timer.dart';
import '../../features/timer/domain/use_cases/start_timer.dart';
import '../router/app_router.dart';

final routerProvider = Provider<GoRouter>((ref) => createAppRouter());

final appLoggerProvider = Provider<AppLogger>((ref) {
  return const NoopAppLogger();
});

final crashReportingServiceProvider = Provider<CrashReportingService>((ref) {
  return const NoopCrashReportingService();
});

final timerRepositoryProvider = Provider<TimerRepository>((ref) {
  return NativeTimerRepository(const TimerMethodChannel());
});

final timerControllerProvider =
    StateNotifierProvider<TimerController, TimerSession>((ref) {
  final repository = ref.watch(timerRepositoryProvider);

  return TimerController(
    startTimer: StartTimer(repository),
    pauseTimer: PauseTimer(repository),
    resumeTimer: ResumeTimer(repository),
    cancelTimer: CancelTimer(repository),
    extendTimer: const ExtendTimer(),
  );
});

final mediaControlRepositoryProvider = Provider<MediaControlRepository>((ref) {
  return NativeMediaControlRepository(const MediaControlChannel());
});

final pauseOrStopMediaProvider = Provider<PauseOrStopMedia>((ref) {
  return PauseOrStopMedia(ref.watch(mediaControlRepositoryProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return MemorySettingsRepository();
});

final sleepSoundRepositoryProvider = Provider<SleepSoundRepository>((ref) {
  return LocalSleepSoundRepository();
});

final listSleepSoundsProvider = Provider<ListSleepSounds>((ref) {
  return ListSleepSounds(ref.watch(sleepSoundRepositoryProvider));
});

final entitlementRepositoryProvider = Provider<EntitlementRepository>((ref) {
  return LocalEntitlementRepository();
});

final currentEntitlementProvider = FutureProvider<Entitlement>((ref) {
  return ref.watch(entitlementRepositoryProvider).currentEntitlement();
});

final adVisibilityPolicyProvider = Provider<AdVisibilityPolicy>((ref) {
  return const AdVisibilityPolicy();
});

final adServiceProvider = Provider<AdService>((ref) {
  return const NoopAdService();
});

final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  return const NoopPurchaseService();
});

final adVisibilityProvider =
    Provider.family<bool, AdPlacement>((ref, placement) {
  final policy = ref.watch(adVisibilityPolicyProvider);
  final entitlement = ref.watch(currentEntitlementProvider).maybeWhen(
        data: (value) => value,
        orElse: () => const Entitlement.free(),
      );

  return policy.shouldShow(
    entitlement: entitlement,
    placement: placement,
  );
});
