#!/bin/bash
rm -rf AppDir
mkdir AppDir
mkdir AppDir/usr
mkdir AppDir/usr/bin
cp -a ../../build/linux/x64/release/bundle/* AppDir/usr/bin/
cp AppDir/usr/bin/data/flutter_assets/assets/icons/icon_256x256.png keyboarddeck.png
./linuxdeploy-x86_64.AppImage --appdir AppDir --desktop-file keyboarddeck.desktop --output appimage -i keyboarddeck.png
rm -rf AppDir
rm -rf keyboarddeck.png
