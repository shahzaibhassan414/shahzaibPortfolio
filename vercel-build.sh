#!/bin/bash

# INSTALL Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1  
export PATH="$PATH:`pwd`/flutter/bin"                                 

# CHECK Flutter
flutter doctor                                                          

# GET DEPENDENCIES
flutter pub get                                                        

# BUILD WEB
# Adding --no-tree-shake-icons to prevent Material Icons from being stripped in release mode
flutter build web --release --pwa-strategy=none --no-tree-shake-icons
