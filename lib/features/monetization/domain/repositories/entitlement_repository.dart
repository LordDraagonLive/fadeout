import '../entities/entitlement.dart';

abstract interface class EntitlementRepository {
  Future<Entitlement> currentEntitlement();
}
