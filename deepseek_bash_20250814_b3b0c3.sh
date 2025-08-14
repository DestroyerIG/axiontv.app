# Android
flutter build apk --target-platform=android-arm64 --release

# Android TV
flutter build apk --target-platform=android-arm64 --release --flavor tv

# iOS
flutter build ios --release

# Apple TV
flutter build ipos --release --dart-define=PLATFORM=apple_tv