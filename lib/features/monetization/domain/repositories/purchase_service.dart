import '../entities/entitlement.dart';

abstract interface class PurchaseService {
  Future<Entitlement> restorePurchases();
  Future<Entitlement> purchaseProLifetime();
}

class NoopPurchaseService implements PurchaseService {
  const NoopPurchaseService();

  @override
  Future<Entitlement> purchaseProLifetime() async {
    return const Entitlement.free();
  }

  @override
  Future<Entitlement> restorePurchases() async {
    return const Entitlement.free();
  }
}
