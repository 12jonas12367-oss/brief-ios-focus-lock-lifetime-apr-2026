# Blockers

## JON-7 (2026-04-23 UTC)

- Blocked deliverable: CI/device validation execution for production Screen Time + StoreKit integrations.
- Unblock owner: Repo maintainer / CI runner owner.
- Unblock action: Execute `dat/VALIDATION_HANDOFF.md`, run `./scripts/capture_validation_evidence.sh` on macOS, and attach completed `dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md`.
- Reason blocked here: local runtime has no Xcode toolchain (`xcodebuild`, `xcodegen`) and no signed Apple environment.
