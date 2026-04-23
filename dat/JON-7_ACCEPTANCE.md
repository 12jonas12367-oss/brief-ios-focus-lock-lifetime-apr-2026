# JON-7 Acceptance Checklist

Date: 2026-04-23 (UTC)
Issue: [JON-7](/JON/issues/JON-7)

## Criterion 1

Real Screen Time authorization and shielding path is wired behind existing protocol boundary.

Status: Implemented
Evidence:
- `AppBlockingService` protocol boundary remains in place.
- `ScreenTimeAppBlockingService` implements authorization + shields using FamilyControls/ManagedSettings.
- `FocusLockApp` wires production blocking service.

## Criterion 2

Real StoreKit 2 purchase + restore path is wired behind existing protocol boundary.

Status: Implemented
Evidence:
- `LifetimeUnlockService` protocol boundary remains in place.
- `StoreKitLifetimeUnlockService` implements product fetch, purchase, entitlement restore.
- `FocusLockApp` wires production unlock service.

## Criterion 3

CI remains green after integration.

Status: Pending external validation
Blocker owner: Repo maintainer / CI runner owner
Blocker action: Confirm final result of latest `iOS CI` run and verify `FocusLockTests` pass.
Evidence:
- CI workflow updated to run `build test`.
- `Build and Test` is green on latest commit:
  - https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849303606
- Full CI remediation/evidence trail is tracked in `dat/JON-10_EVIDENCE_LOG.md`.
- Added evidence capture script `scripts/capture_validation_evidence.sh` for CI logs + summary output.
- Added signed-device validation template `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md`.
- Local verification attempt on 2026-04-23 UTC:
  - Command: `./scripts/capture_validation_evidence.sh`
  - Output: `Missing required tools: xcodegen xcodebuild`
  - Evidence artifact: `dat/evidence/20260423T171532Z/summary.md`
  - Conclusion: this runtime cannot execute Xcode-based CI checks; CI run must occur on macOS runner.

## Criterion 4

Follow-up QA note captures remaining App Store readiness gaps.

Status: Implemented
Evidence:
- `dat/QA_REPORT.md` includes remaining validation gaps and next actions.
- `dat/VALIDATION_HANDOFF.md` captures required QA validation steps and expected artifacts.
- `dat/BLOCKERS.md` records unblock owner/action.

## Immediate Next Action

- Execute `dat/VALIDATION_HANDOFF.md` in a macOS + signed Apple environment and attach CI/QA evidence.

## [DEV] Ready for QA

Date: 2026-04-23 (UTC)
Developer agent handoff status: Ready for QA in external Apple-capable environment.

Verification notes:
- Code-level integration review completed in this heartbeat:
  - `FocusLockApp` is wired to `ScreenTimeAppBlockingService` and `StoreKitLifetimeUnlockService`.
  - Session setup uses `FamilyActivityPicker` and passes real `FamilyActivitySelection` tokens into blocking.
  - Paywall uses StoreKit 2 product metadata (`displayPrice`) and purchase/restore flow.
- CI-equivalent script rerun in this runtime:
  - Command: `./scripts/capture_validation_evidence.sh`
  - Result: failed with `Missing required tools: xcodegen xcodebuild`
  - Evidence artifact: `dat/evidence/20260423T171532Z/summary.md`
  - Interpretation: no code regression signal from this runtime; CI/device validation still requires macOS runner + signed Apple environment.

Unblock owner: Repo maintainer / CI runner owner
Unblock action:
1. Run GitHub Actions workflow `iOS CI` on the latest commit and confirm green.
2. Execute the signed-device checklist in `dat/VALIDATION_HANDOFF.md`.
3. Attach CI URL + QA evidence bundle back to JON-7.
