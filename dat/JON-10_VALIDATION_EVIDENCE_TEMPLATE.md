# JON-10 Validation Evidence Template

Date: <!-- YYYY-MM-DD UTC -->
Issue: [JON-10](/JON/issues/JON-10)
Related issue: [JON-7](/JON/issues/JON-7)

## 1) CI Evidence

- Commit SHA: `<!-- paste -->`
- Workflow name: `iOS CI`
- Workflow run URL: <!-- paste -->
- Run result: <!-- passed/failed -->
- `FocusLockTests` result: <!-- passed/failed -->
- Artifact/log bundle path: `<!-- dat/evidence/<timestamp> -->`

Command used on macOS runner:

```bash
./scripts/capture_validation_evidence.sh
```

## 2) Signed Device Evidence

- Build environment:
- Xcode version:
- iOS version:
- Device model:
- Signed Apple Developer team/app identifier:

### Screen Time Validation

1. Family Controls authorization prompt completed: <!-- yes/no + evidence -->
2. Shield applied after session start: <!-- yes/no + screenshot/video -->
3. Shield removed after session end: <!-- yes/no + screenshot/video -->

### StoreKit Validation

1. Product `focus_lock_lifetime_unlock` loads with localized price: <!-- yes/no + screenshot -->
2. Purchase succeeds and unlock persists: <!-- yes/no + screenshot/video -->
3. Restore succeeds and entitlement rehydrates: <!-- yes/no + screenshot/video -->

## 3) Attachments

- CI logs: `<!-- path or link -->`
- Screen Time media: `<!-- path or link -->`
- StoreKit media: `<!-- path or link -->`
- Additional notes/errors (include exact step + stack trace): <!-- details -->

## 4) Sign-off

- Validator:
- Completed at (UTC):
- Unblock recommendation for JON-7: <!-- ready / not ready -->
