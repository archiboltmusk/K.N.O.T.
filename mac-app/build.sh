#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_BUNDLE="$DIR/KNOT.app"
CONTENTS="$APP_BUNDLE/Contents"
MACOS="$CONTENTS/MacOS"
RESOURCES="$CONTENTS/Resources"

mkdir -p "$MACOS" "$RESOURCES"

cat <<EOF > "$CONTENTS/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>KNOT</string>
    <key>CFBundleIdentifier</key>
    <string>app.knot.desktop</string>
    <key>CFBundleName</key>
    <string>K.N.O.T.</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>2.0.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

echo "Compiling native Swift sources for macOS..."
swiftc -parse-as-library -target arm64-apple-macosx13.0 \
  "$DIR/Sources/Theme.swift" \
  "$DIR/Sources/Models.swift" \
  "$DIR/Sources/Engine.swift" \
  "$DIR/Sources/OnboardingView.swift" \
  "$DIR/Sources/DailyDropsView.swift" \
  "$DIR/Sources/PushCardView.swift" \
  "$DIR/Sources/DateConciergeView.swift" \
  "$DIR/Sources/ElderObserverView.swift" \
  "$DIR/Sources/ContentView.swift" \
  "$DIR/Sources/App.swift" \
  -o "$MACOS/KNOT"

echo "Signing application bundle..."
codesign --force --deep --sign - "$APP_BUNDLE"

echo "======================================================="
echo "✅ Successfully built native Mac app: $APP_BUNDLE"
echo "Launch with: open \"$APP_BUNDLE\""
echo "======================================================="
