import 'package:fadeout/features/monetization/domain/entities/entitlement.dart';
import 'package:fadeout/features/monetization/domain/services/ad_visibility_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const policy = AdVisibilityPolicy();

  test('free users see ads on home and settings only', () {
    const entitlement = Entitlement.free();

    expect(
      policy.shouldShow(
        entitlement: entitlement,
        placement: AdPlacement.home,
      ),
      true,
    );
    expect(
      policy.shouldShow(
        entitlement: entitlement,
        placement: AdPlacement.settings,
      ),
      true,
    );
    expect(
      policy.shouldShow(
        entitlement: entitlement,
        placement: AdPlacement.activeTimer,
      ),
      false,
    );
  });

  test('pro users do not see ads', () {
    const entitlement = Entitlement(
      kind: EntitlementKind.proLifetime,
      isActive: true,
    );

    expect(
      policy.shouldShow(
        entitlement: entitlement,
        placement: AdPlacement.home,
      ),
      false,
    );
  });
}
