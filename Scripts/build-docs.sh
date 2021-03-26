#!/bin/sh

#
# Build reference documentation
#

MODULE=SettingsKit
AUTHOR="Apparata AB"
AUTHOR_URL=https://apparata.se
GITHUB_URL=https://github.com/apparata/SettingsKit

# Change directory to where this script is located and go up one step
cd "$(dirname ${BASH_SOURCE[0]})/.."

# The output will go in Docs/Reference/${MODULE}
rm -rf "Docs/Reference/${MODULE}"
mkdir -p "Docs/Reference/${MODULE}"

jazzy \
  --clean \
  --module $MODULE \
  --author $AUTHOR \
  --author_url $AUTHOR_URL \
  --output "Docs/Reference/${MODULE}" \
  --readme "README.md" \
  --theme fullwidth \
  --source-directory . \
  --swift-build-tool spm \
  --build-tool-arguments -Xswiftc,-swift-version,-Xswiftc,5
#  --github_url $GITHUB_URL

# To open the index page:
# open "Docs/Reference/${MODULE}/index.html"
