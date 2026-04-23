#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v xcodegen >/dev/null 2>&1; then
  echo "xcodegen is required but not installed"
  exit 1
fi

if ! command -v xcodebuild >/dev/null 2>&1; then
  echo "xcodebuild is required but not installed"
  exit 1
fi

xcodegen generate

xcodebuild \
  -project FocusLock.xcodeproj \
  -scheme FocusLock \
  -configuration Debug \
  -destination "platform=iOS Simulator,name=iPhone 16,OS=latest" \
  -derivedDataPath DerivedData \
  build test
