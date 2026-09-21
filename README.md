# 🏴 The Bounty Board (バウンティボード)

An anime and Japanese aesthetics-themed productivity app & Android Home Screen widget built with **Flutter** and native **Android Kotlin RemoteViews**.

---

## ✨ Features

- 📜 **Full Multi-line Android Home Screen Widget**:
  - Instant live task rendering with no background service lag.
  - Multi-line text wrapping so long tasks are never cut off.
  - Interactive quick-add (`+`) button deep-linking directly into task creation.
  - Dynamic wallpaper backgrounds changing in real time with your theme.
- 🎨 **10 Custom Anime & Japanese Themes**:
  - 🌙 **Midnight Bounty** — Cosmic purple nebula
  - 🍥 **Ninja Scroll (巻物)** — *Naruto* blazing orange chakra aura
  - ⚔️ **Demon Slayer (鬼滅)** — *Kimetsu no Yaiba* crimson nichirin flames
  - 👁️ **Cursed Energy (呪力)** — *Jujutsu Kaisen* infinite void navy & purple aura
  - ☠️ **Pirate King (海賊王)** — *One Piece* ocean waves & treasure gold
  - 🌸 **Sakura (桜)** — Kyoto cherry blossom soft pink & white
  - 🗡️ **Bushido (武士道)** — Sengoku lacquer armor & samurai gold
  - 🌆 **Tokyo Neon (東京)** — Cyberpunk midnight & electric cyan
  - 🌿 **Forest Spirit (森)** — *Studio Ghibli* lush greens & sacred moss
  - 🖌️ **Ink Wash (水墨)** — Traditional *Sumi-e* ink & washi parchment
- 🔤 **Customizable Font Sizes**:
  - Small (11sp), Medium (13sp), Large (15sp), and Extra Large (17sp).
  - Synchronized instantly across the in-app list and the home screen widget.
- ⚡ **100% Offline & Private**:
  - High-performance local persistence using **Hive**.
  - Zero cloud dependency, zero trackers.

---

## 📱 Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart 3)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Local Database**: [Hive](https://pub.dev/packages/hive) & [Hive Flutter](https://pub.dev/packages/hive_flutter)
- **Widget Integration**: [home_widget](https://pub.dev/packages/home_widget) + Kotlin `RemoteViews`
- **Platforms**: Android (Primary with Widget) & Windows / Multiplatform

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.24+)
- Android SDK (API 34+) & JDK 17

### Build & Run
```bash
# 1. Install dependencies
flutter pub get

# 2. Run on connected device or emulator
flutter run

# 3. Build Release APK
flutter build apk --release
```

The compiled APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 📜 License
MIT License
