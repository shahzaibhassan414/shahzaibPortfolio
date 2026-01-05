#!/bin/bash
set -euo pipefail

# Install a known Flutter version into the build environment
FLUTTER_VERSION="3.22.3"
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar -xJf -

export PATH="$PWD/flutter/bin:$PATH"

# Prepare and build for the web
flutter config --enable-web
flutter pub get
flutter build web --release --web-renderer=canvaskit
