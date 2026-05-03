import 'package:go_router/go_router.dart';

import '../../features/monetization/presentation/screens/upgrade_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/timer/presentation/screens/active_timer_screen.dart';
import '../../features/timer/presentation/screens/home_timer_screen.dart';
import 'app_routes.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeTimerScreen(),
      ),
      GoRoute(
        path: AppRoutes.activeTimer,
        builder: (context, state) => const ActiveTimerScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.upgrade,
        builder: (context, state) => const UpgradeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
