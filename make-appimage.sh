#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q extension-manager | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/com.mattjakeman.ExtensionManager.svg
export DESKTOP=/usr/share/applications/com.mattjakeman.ExtensionManager.desktop
export DEPLOY_VULKAN=1
export DEPLOY_OPENGL=1
export STARTUPWMCLASS=com.mattjakeman.ExtensionManager

# Deploy dependencies
quick-sharun  /usr/bin/extension-manager \
              /usr/lib/gio/modules/libgiognutls.so

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
