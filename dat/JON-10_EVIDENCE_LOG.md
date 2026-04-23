# JON-10 CI + Device Validation Evidence Log

Date: 2026-04-23 (UTC)
Issue: [JON-10](/JON/issues/JON-10)
Related issue: [JON-7](/JON/issues/JON-7)
Latest commit under validation: `e735b5b`

## CI Evidence

- Green CI run (`Build and Test`) on latest commit:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848945440
  - Workflow: `Build and Test`
  - Result: `success`

- Green CI run after destination compatibility fix:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849303606
  - Workflow: `Build and Test`
  - Result: `success`

- Test-enabled workflow (`iOS CI`) remediation trail:
  1. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848714527
     - Result: `failure`
     - Defects fixed: missing test target plist generation; Swift concurrency diagnostics on `SessionConfig.default`.
  2. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848777543
     - Result: `failure`
     - Defect fixed: actor-isolation issue when sending `authorizationCenter` across isolation boundary.
  3. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848880135
     - Result: `failure`
     - Defect fixed: nonisolated references to main-actor properties in `SessionCoordinator`.
  4. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848945396
     - Result: `cancelled` (manual cancellation after prolonged in-progress state).
  5. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849214311
     - Result: `failure`
     - Defect fixed: legacy `Build and Test` workflow device destination (`iPhone 16`) not available on runner image.
  6. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849303588
     - Result: `pending` (blocked behind prior in-progress run at time of this update).

## Signed-Device Evidence

- Status: `pending external execution`
- Reason: signed Apple Developer environment + device interaction required.
- Required checklist: `dat/VALIDATION_HANDOFF.md`
- Template to fill and attach: `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md`

## Current Unblock State

- CI: partially unblocked (`Build and Test` green on latest commit; `iOS CI` pending final terminal result).
- Signed-device validation: blocked.

Unblock owner: Repo maintainer / QA owner with signed Apple environment.
Unblock action:
1. Confirm final state of `iOS CI` run `24848945396` (or rerun `iOS CI` if it times out).
2. Execute signed-device checklist and attach media artifacts.
3. Post completed evidence bundle back to JON-7 and JON-10.
