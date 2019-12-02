#!/bin/sh

# Change directory to where this script is located and go up one step
cd "$(dirname ${BASH_SOURCE[0]})/.."

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
