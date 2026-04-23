#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

STAMP="$(date -u +"%Y%m%dT%H%M%SZ")"
OUT_DIR="${1:-"$REPO_ROOT/dat/evidence/$STAMP"}"
mkdir -p "$OUT_DIR"

CI_LOG="$OUT_DIR/ci_build_test.log"
SUMMARY="$OUT_DIR/summary.md"

cat > "$SUMMARY" <<EOF
# Validation Evidence Summary

- Generated at (UTC): $(date -u +"%Y-%m-%d %H:%M:%S")
- Commit: $(git rev-parse HEAD)
- Output directory: $OUT_DIR
EOF

missing_tools=()
for tool in xcodegen xcodebuild; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    missing_tools+=("$tool")
  fi
done

if [ "${#missing_tools[@]}" -gt 0 ]; then
  {
    echo
    echo "## CI Execution"
    echo
    echo "Status: blocked"
    echo "Missing tools: ${missing_tools[*]}"
    echo
    echo "Run this script on a macOS runner with Xcode installed."
  } >> "$SUMMARY"
  echo "Missing required tools: ${missing_tools[*]}"
  echo "Summary written to: $SUMMARY"
  exit 2
fi

set -o pipefail
xcodegen generate 2>&1 | tee "$OUT_DIR/xcodegen.log"
xcodebuild \
  -project FocusLock.xcodeproj \
  -scheme FocusLock \
  -configuration Debug \
  -destination "platform=iOS Simulator,name=iPhone 16,OS=latest" \
  -derivedDataPath DerivedData \
  build test 2>&1 | tee "$CI_LOG"
set +o pipefail

{
  echo
  echo "## CI Execution"
  echo
  echo "Status: passed"
  echo "- xcodegen output: $OUT_DIR/xcodegen.log"
  echo "- xcodebuild output: $CI_LOG"
  echo
  echo "## Signed Device Validation"
  echo
  echo "Complete the checklist in dat/JON-10_VALIDATION_EVIDENCE_TEMPLATE.md and attach media artifacts."
} >> "$SUMMARY"

echo "Validation evidence captured in: $OUT_DIR"
