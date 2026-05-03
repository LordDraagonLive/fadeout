import '../services/ad_visibility_policy.dart';

abstract interface class AdService {
  Future<void> preload(AdPlacement placement);
  Future<void> markImpression(AdPlacement placement);
}

class NoopAdService implements AdService {
  const NoopAdService();

  @override
  Future<void> markImpression(AdPlacement placement) async {}

  @override
  Future<void> preload(AdPlacement placement) async {}
}
