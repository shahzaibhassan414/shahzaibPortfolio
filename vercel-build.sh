#!/bin/bash

# INSTALL Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1  # ADDED
export PATH="$PATH:`pwd`/flutter/bin"                                   # ADDED

# CHECK Flutter
flutter doctor                                                          # ADDED

# GET DEPENDENCIES
flutter pub get                                                         # ADDED

# BUILD WEB
flutter build web                                                       # ADDED
