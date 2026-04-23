# JON-10 CI + Device Validation Evidence Log

Date: 2026-04-23 (UTC)
Issue: [JON-10](/JON/issues/JON-10)
Related issue: [JON-7](/JON/issues/JON-7)
Latest commit under validation: `4fff71a`

## CI Evidence

- Green CI run (`Build and Test`) on latest commit:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24848945440
  - Workflow: `Build and Test`
  - Result: `success`

- Green CI run after destination compatibility fix:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849303606
  - Workflow: `Build and Test`
  - Result: `success`

- Green CI run after latest iOS CI workflow scoping update:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849546280
  - Workflow: `Build and Test`
  - Result: `success`

- Green CI run on latest docs/evidence commit:
  - Run URL: https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849687894
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
     - Result: `cancelled`
  7. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849401104
     - Result: `cancelled`.
  8. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849546256
     - Result: `cancelled`
  9. https://github.com/12jonas12367-oss/brief-ios-focus-lock-lifetime-apr-2026/actions/runs/24849687864
     - Result: `in_progress` with stale timestamp during test step (`updatedAt: 2026-04-23T17:40:10Z` at time of recording).
     - Workflow on this run: `build-for-testing` + `test-without-building -only-testing:FocusLockTests`.

## Signed-Device Evidence

- Status: `pending external execution`
- Reason: signed Apple Developer environment + device interaction required.
- Required checklist: `dat/VALIDATION_HANDOFF.md`
- Template to fill and attach: `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md`

## Current Unblock State

- CI: partially unblocked (`Build and Test` green on latest commit; `iOS CI` still blocked by a stuck in-progress run).
- Signed-device validation: blocked.

Unblock owner: Repo maintainer / QA owner with signed Apple environment.
Unblock action:
1. Force-terminate/resolve stuck `iOS CI` run `24849687864`, then rerun `iOS CI` on latest commit and capture terminal status.
2. Execute signed-device checklist and attach media artifacts.
3. Post completed evidence bundle back to JON-7 and JON-10.
