import '../entities/entitlement.dart';

enum AdPlacement {
  home,
  settings,
  activeTimer,
  upgrade,
}

class AdVisibilityPolicy {
  const AdVisibilityPolicy();

  bool shouldShow({
    required Entitlement entitlement,
    required AdPlacement placement,
  }) {
    if (entitlement.removesAds) {
      return false;
    }

    return switch (placement) {
      AdPlacement.home || AdPlacement.settings => true,
      AdPlacement.activeTimer || AdPlacement.upgrade => false,
    };
  }
}
