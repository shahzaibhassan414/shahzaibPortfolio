#!/bin/bash

# Set a Flutter version
FLUTTER_VERSION="3.19.6"

# Clone the Flutter repository with the specified version
git clone https://github.com/flutter/flutter.git --depth 1 --branch $FLUTTER_VERSION
export PATH="$PATH:`pwd`/flutter/bin"

# Run flutter doctor to verify the installation
flutter doctor

# Build the Flutter web application
flutter build web --release
