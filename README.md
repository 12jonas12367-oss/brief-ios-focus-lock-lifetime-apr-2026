# Focus Lock MVP Scaffold

This repository now contains a runnable iOS app scaffold for the Focus Lock MVP based on `RESEARCH_BRIEF.md`.

## What is implemented

- SwiftUI app skeleton via XcodeGen (`project.yml`) with iOS 18.6 deployment target.
- Three MVP screens:
  - Home
  - Session Setup
  - Active Session countdown
- End-to-end paywall UI path for lifetime unlock.
- Service interfaces for blocking and purchases with mock implementations.

## Architecture notes

- `SessionCoordinator` orchestrates flow and app state.
- `AppBlockingService` defines the Screen Time enforcement boundary.
- `LifetimeUnlockService` defines the StoreKit 2 purchase boundary.
- Current services are mock implementations to keep simulator/dev mode runnable while preserving production integration points.

## Screen Time integration approach

- Planned production path: `FamilyControls` + `ManagedSettings` for app/category shields.
- Current state: mocked start/stop calls in `MockAppBlockingService`.
- Next milestone: add an iOS-only concrete service that requests authorization and applies shields.

## Paywall wiring approach

- Current state: full-screen paywall sheet with one clear unlock CTA and restore action.
- TODO marker for product id: `focus_lock_lifetime_unlock`.
- Next milestone: replace mock purchase service with StoreKit 2 (`Product.products(for:)`, `Product.purchase()`, and restore through entitlements).

## How to run

1. On macOS, install XcodeGen if needed.
2. Run `xcodegen generate` in repo root.
3. Open generated `FocusLock.xcodeproj` in Xcode.
4. Build and run `FocusLock` on an iOS 18.6+ simulator.

## Implemented vs mocked

- Implemented: navigation flow, session setup data model, active countdown, paywall path.
- Mocked: actual Screen Time shielding and real StoreKit transactions.
