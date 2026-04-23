# Focus Lock MVP Scaffold

This repository contains a runnable iOS app scaffold for Focus Lock based on `RESEARCH_BRIEF.md`.

## What is implemented

- SwiftUI app skeleton via XcodeGen (`project.yml`) with iOS 18.5 deployment target.
- Three MVP screens:
  - Home
  - Session Setup
  - Active Session countdown
- End-to-end paywall UI path for lifetime unlock.
- Production service implementations for:
  - Screen Time authorization and shielding (`FamilyControls` + `ManagedSettings`)
  - Lifetime unlock purchases and restore (`StoreKit 2`)
- Unit-test target (`FocusLockTests`) covering key `SessionCoordinator` flows.

## Architecture notes

- `SessionCoordinator` orchestrates flow and app state.
- `AppBlockingService` defines the Screen Time enforcement boundary.
- `LifetimeUnlockService` defines the StoreKit 2 purchase boundary.
- App startup wires concrete production services in `FocusLockApp`.

## Screen Time integration

- Uses `AuthorizationCenter.shared.requestAuthorization(for: .individual)`.
- Uses `FamilyActivityPicker` in Session Setup to collect app/category/web selections.
- Stores session blocking targets as `FamilyActivitySelection` tokens in `SessionConfig`.
- Applies shields through `ManagedSettingsStore` while a session is active.
- Clears shields when the session ends.

## Paywall wiring

- Uses product id: `focus_lock_lifetime_unlock`.
- Loads product metadata from StoreKit 2 and surfaces localized `displayPrice` in paywall UI.
- Calls `Product.purchase()` for unlock and `AppStore.sync()` + `Transaction.currentEntitlements` for restore.

## How to run

1. On macOS, install XcodeGen if needed.
2. Run `xcodegen generate` in repo root.
3. Open generated `FocusLock.xcodeproj` in Xcode.
4. In Signing & Capabilities:
   - Add **Family Controls** entitlement (approved provisioning required).
   - Add **In-App Purchase** capability.
5. Ensure App Store Connect product `focus_lock_lifetime_unlock` exists.
6. Build and run `FocusLock` on an iOS 18.5+ device/simulator.
7. Optional CI-equivalent validation artifact capture: `./scripts/capture_validation_evidence.sh`.
8. Fill `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md` with CI URL + signed-device proof.

## Remaining work

- Add focused QA run with screenshots on a signed build.
- Add production error telemetry around authorization/purchase failures.
