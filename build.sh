#!/bin/bash
set -euo pipefail

# Install a known Flutter version into the build environment
FLUTTER_VERSION="3.22.3"
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar -xJf -

export PATH="$PWD/flutter/bin:$PATH"

# Allow flutter's internal git repo under the Vercel build path
git config --global --add safe.directory "$PWD/flutter"

# Prepare and build for the web (non-interactive)
flutter config --no-analytics
flutter config --enable-web
flutter pub get
flutter build web --release --web-renderer=canvaskit
