# Validation Handoff - JON-7

Date: 2026-04-23 (UTC)
Issue: [JON-7](/JON/issues/JON-7)

## Blocked In This Runtime

- Local environment does not provide `xcodebuild` or `xcodegen`.
- Production validation must run on GitHub Actions/macOS + signed Apple developer environment.

## Unblock Owner

- Repo maintainer / CI runner owner

## Required Unblock Actions

1. Push current branch and run workflow `iOS CI`.
   - Can be started from Actions UI via `workflow_dispatch` if no new push is needed.
   - Local equivalent command: `./scripts/capture_validation_evidence.sh`.
2. Confirm workflow finishes green on latest commit.
3. Confirm `FocusLockTests` pass in CI output.
4. On a signed build in Xcode, verify Family Controls capability is enabled and authorization prompt completes.
5. Start a session with selected apps/categories/websites and confirm shields are applied.
6. End session and confirm shields are removed.
7. Verify StoreKit product `focus_lock_lifetime_unlock` loads localized price on paywall.
8. Complete purchase in StoreKit test environment and confirm unlock state persists.
9. Run restore flow and confirm entitlement is rehydrated.
10. Capture screenshots/video for session start, active blocking, purchase success, restore success.
11. Fill `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md` and attach links/paths.

## Expected Artifacts

- GitHub Actions run URL with green status.
- QA evidence bundle (screenshots/video + brief notes) using `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md`.
- Any runtime errors with exact step and device/iOS version.
