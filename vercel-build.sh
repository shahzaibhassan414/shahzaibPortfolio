#!/bin/bash

# INSTALL Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1  
export PATH="$PATH:`pwd`/flutter/bin"                                 

# CHECK Flutter
flutter doctor                                                          

# GET DEPENDENCIES
flutter pub get                                                        

# BUILD WEB
flutter build web --release --dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID"
