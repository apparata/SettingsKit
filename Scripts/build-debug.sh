#!/bin/sh

# Change directory to where this script is located and go up one step
cd "$(dirname ${BASH_SOURCE[0]})/.."

swift package clean
swift build --configuration debug
