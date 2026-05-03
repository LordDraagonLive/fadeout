import '../../domain/entities/entitlement.dart';
import '../../domain/repositories/entitlement_repository.dart';

class LocalEntitlementRepository implements EntitlementRepository {
  LocalEntitlementRepository({
    Entitlement entitlement = const Entitlement.free(),
  }) : _entitlement = entitlement;

  Entitlement _entitlement;

  @override
  Future<Entitlement> currentEntitlement() async {
    return _entitlement;
  }

  Future<void> setEntitlement(Entitlement entitlement) async {
    _entitlement = entitlement;
  }
}
