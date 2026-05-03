enum EntitlementKind {
  free,
  proLifetime,
  subscription,
}

class Entitlement {
  const Entitlement({
    required this.kind,
    required this.isActive,
  });

  const Entitlement.free()
      : kind = EntitlementKind.free,
        isActive = true;

  final EntitlementKind kind;
  final bool isActive;

  bool get removesAds {
    return isActive &&
        (kind == EntitlementKind.proLifetime ||
            kind == EntitlementKind.subscription);
  }

  bool get unlocksAdvancedFade {
    return isActive &&
        (kind == EntitlementKind.proLifetime ||
            kind == EntitlementKind.subscription);
  }
}
