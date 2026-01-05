#!/bin/bash

# Set a Flutter version
FLUTTER_VERSION="3.19.6"
FLUTTER_SDK_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

# Download and extract Flutter SDK
wget $FLUTTER_SDK_URL
tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# Add flutter to path
export PATH="$PATH:`pwd`/flutter/bin"

# Precache flutter artifacts
flutter precache

# Build the Flutter web application
flutter build web --release
