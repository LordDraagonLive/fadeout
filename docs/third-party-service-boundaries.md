# Third-Party Service Boundaries

FadeOut should keep ad networks, purchase providers, analytics, and crash
reporting behind provider-neutral interfaces until a vendor is selected.

## MVP Rule

Do not import provider SDKs directly into widgets, controllers, domain objects,
or use cases.

Provider SDKs should only appear inside adapter implementations under `data/`
or `core/services/`.

## Reserved Interfaces

Current blank service boundaries:

```text
CrashReportingService
AdService
PurchaseService
EntitlementRepository
```

Current no-op implementations:

```text
NoopCrashReportingService
NoopAdService
NoopPurchaseService
LocalEntitlementRepository
```

These allow the app to call the service layer now while choosing the actual
companies later.

## Future Adapter Examples

Possible adapter names after vendor selection:

```text
VendorCrashReportingService
VendorAdService
VendorPurchaseService
VendorEntitlementRepository
```

Use actual company names only after the provider decision is final.

## Hard Rules

- Ads can appear only on home and settings for users without a paid entitlement.
- Ads must never appear on the active timer screen.
- Purchase UI must call `PurchaseService`, not store SDKs directly.
- Pro/subscription checks must go through `EntitlementRepository`.
- Crash reporting must go through `CrashReportingService`.
