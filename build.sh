#!/bin/bash
set -euo pipefail
set -x

# Force a writable HOME for git/flutter configs (Vercel runs as root)
export HOME="$PWD/.home"
mkdir -p "$HOME"

# Install a known Flutter version into the build environment
FLUTTER_VERSION="3.38.5"
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar -xJf -

export FLUTTER_ROOT="$PWD/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PUB_CACHE="$PWD/.pub-cache"

# Allow flutter's internal git repo under the Vercel build path
git config --global --add safe.directory "$FLUTTER_ROOT"
git config --global --add safe.directory "$PWD"

# Prepare and build for the web (non-interactive)
flutter config --no-analytics
flutter config --enable-web
flutter --version
flutter precache --web
flutter pub get
flutter build web --release -v

