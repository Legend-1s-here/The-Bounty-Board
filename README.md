<div align="center"> <img src="https://files.manuscdn.com/user_upload_by_module/session_file/310519663886659791/LwnnblvUiaxYbQeX.png" alt="The Bounty Board — anime-styled productivity app and Android home-screen widget" width="100%" /> <h1>🏴 THE BOUNTY BOARD</h1> <h3><em>Turn the things you need to do into quests worth claiming.</em></h3> <p><strong>An anime and Japanese-aesthetics task board with a live Android home-screen widget.</strong></p>

[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Android](https://img.shields.io/badge/Android-Widget-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://developer.android.com/)
[![Hive](https://img.shields.io/badge/Storage-Hive-F6C344?style=for-the-badge)](https://pub.dev/packages/hive)
[![License](https://img.shields.io/badge/License-MIT-A894E6?style=for-the-badge)](./LICENSE)


<blockquote><strong>Your home screen should remember the mission.</strong></blockquote> </div>

---

<div align="center">

![01 The Quest](https://img.shields.io/badge/01-THE_QUEST-A894E6?style=for-the-badge&labelColor=12101F)

<h2>A tiny board with the presence of a whole world.</h2> </div>

**The Bounty Board** is a focused task manager built for people who want productivity to feel personal. Add a task, claim it when it is done, and keep the current mission visible without opening the app.

It combines a Material 3 Flutter interface with a native Android `RemoteViews` widget, local Hive persistence, deep-linked quick add, dynamic wallpapers, and ten distinct visual themes inspired by anime worlds and Japanese design.

<table>
<tr>
<td width="25%" align="center"><strong>POST</strong>  
<sub>Add a new bounty</sub></td>
<td width="25%" align="center"><strong>TRACK</strong>  
<sub>See active missions</sub></td>
<td width="25%" align="center"><strong>CLAIM</strong>  
<sub>Complete the task</sub></td>
<td width="25%" align="center"><strong>REMEMBER</strong>  
<sub>Keep it on the widget</sub></td>
</tr>
</table>

## 

<div align="center">

![02 Home Screen Widget](https://img.shields.io/badge/02-HOME_SCREEN_WIDGET-FF6B00?style=for-the-badge&labelColor=12101F)

<h2>The mission stays visible.</h2> </div>

The Android widget is not a static shortcut. It renders the current bounty list, active-count badge, themed wallpaper, bullet style, font size, and quick-add action directly on the home screen.

<div align="center"> <img src="https://files.manuscdn.com/user_upload_by_module/session_file/310519663886659791/NnKtXXtNDuqfaFLl.jpeg" alt="The Bounty Board Android home-screen widget showing active tasks over an anime wallpaper" width="56%" />

<sub><strong>Full multi-line task rendering · themed wallpaper · one-tap quick add.</strong></sub>

</div>

### Widget behavior

- Displays up to **five active tasks** with readable multi-line wrapping.

- Shows an additional `+ N more in app...` indicator when more tasks remain.

- Updates the active bounty count beside the themed title.

- Uses a real wallpaper resource and a translucent scrim for contrast.

- Changes its title, button, bullet, accent, and wallpaper when the theme changes.

- Tapping the widget opens the app; tapping `+` opens the add-bounty sheet directly.

- Font-size changes are synchronized between the Flutter list and the Android widget.

## 

<div align="center">

![03 Theme Arsenal](https://img.shields.io/badge/03-THEME_ARSENAL-E91E8C?style=for-the-badge&labelColor=12101F)

<h2>Choose the world your tasks belong to.</h2> </div>

Open the palette button and choose a visual mode from a draggable theme sheet. The selected theme is persisted locally and pushed to the widget so the app and home screen always speak the same visual language.

<div align="center"> <img src="https://files.manuscdn.com/user_upload_by_module/session_file/310519663886659791/LuwGtSKOoaJYvnbd.jpeg" alt="The Bounty Board theme picker showing multiple anime and Japanese visual themes" width="56%" />

<sub><strong>Ten worlds. One board. Switch the atmosphere whenever the mission changes.</strong></sub>

</div>

| Theme | Atmosphere | Theme | Atmosphere |
| --- | --- | --- | --- |
| 🌙 **Midnight Bounty** | Cosmic purple nebula | 🍥 **Ninja Scroll** | Blazing orange shinobi energy |
| ⚔️ **Demon Slayer** | Crimson nichirin flame | 👁️ **Cursed Energy** | Deep navy and infinite violet |
| ☠️ **Pirate King** | Ocean blue and treasure gold | 🌸 **Sakura** | Cherry blossom pink and spring light |
| 🗡️ **Bushido** | Lacquer, crimson, and samurai gold | 🌆 **Tokyo Neon** | Cyberpunk cyan after dark |
| 🌿 **Forest Spirit** | Soft green nature magic | 🖌️ **Ink Wash** | Sumi-e black and washi white |

## 

<div align="center">

![04 Board Controls](https://img.shields.io/badge/04-BOARD_CONTROLS-00BCD4?style=for-the-badge&labelColor=12101F)

</div> <table>
<tr>
<td width="50%" valign="top"> <h3>◉ ACTIVE / CLAIMED FILTERS</h3>

Switch between the full board, active bounties, and claimed bounties with compact filter chips. The stats bar keeps active and completed totals visible at a glance.

</td>
<td width="50%" valign="top"> <h3>◉ ADD BOUNTY</h3>

Use the extended floating action button inside the app or the widget’s `+` button to open the same task-creation flow.

</td>
</tr>
<tr>
<td width="50%" valign="top"> <h3>◉ FONT SIZE</h3>

Choose Small, Medium, Large, or Extra Large text. The setting is saved and applied to both the in-app task rows and the home-screen widget.

</td>
<td width="50%" valign="top"> <h3>◉ CLEAR THE CLAIMED</h3>

When the board is full of completed work, remove claimed bounties in one deliberate action instead of deleting tasks one by one.

</td>
</tr>
</table>

## 

<div align="center">

![05 Privacy First](https://img.shields.io/badge/05-PRIVACY_FIRST-4CAF50?style=for-the-badge&labelColor=12101F)

<h2>Your bounties stay on your device.</h2> </div>

The app is designed around local-first productivity. Tasks and preferences are stored with Hive, with no account flow, cloud database, analytics service, or tracker required to use the board.

- **Local persistence** through Hive boxes for tasks and settings.

- **Offline-first behavior** for adding, completing, filtering, and deleting bounties.

- **No cloud dependency** for the core experience.

- **Widget synchronization** only writes the current task and theme state needed for the Android home screen.

## 

<div align="center">

![06 Under The Hood](https://img.shields.io/badge/06-UNDER_THE_HOOD-7B2FBE?style=for-the-badge&labelColor=12101F)

</div>

```
Flutter UI
   │
   ├── TaskProvider ───── Hive `tasks` box
   │        │
   │        └── active / completed / all filters
   │
   ├── ThemeProvider ──── Hive `settings` box
   │        │
   │        └── theme id + font size
   │
   └── HomeWidget bridge
             │
             └── Android Kotlin TodoWidget
                    │
                    ├── RemoteViews layout
                    ├── themed wallpaper + scrim
                    ├── task rows and active badge
                    └── deep-linked add-bounty action
```

### The synchronization loop

1. A task is added, toggled, deleted, or cleared in Flutter.

1. `TaskProvider` persists the change to Hive.

1. The provider serializes the active task titles and count.

1. `home_widget` requests a native Android widget refresh.

1. `TodoWidget.kt` applies the current theme, font size, task rows, and quick-add intent.

## 

<div align="center">

![07 Project Anatomy](https://img.shields.io/badge/07-PROJECT_ANATOMY-FFD700?style=for-the-badge&labelColor=12101F)

</div>

```
The-Bounty-Board/
├── lib/
│   ├── main.dart                    # App bootstrap and providers
│   ├── models/task.dart              # Hive-backed task model
│   ├── providers/task_provider.dart  # CRUD, filters, widget task sync
│   ├── providers/theme_provider.dart # Theme + font-size persistence
│   ├── screens/
│   │   ├── home_screen.dart          # Board, stats, filters, FAB
│   │   ├── add_task_screen.dart       # Add-bounty flow
│   │   ├── theme_picker_screen.dart   # Theme gallery
│   │   └── font_size_sheet.dart       # Widget + app text sizing
│   ├── themes/app_themes.dart         # Ten visual theme definitions
│   └── widgets/task_tile.dart         # Task row presentation
├── android/app/src/main/kotlin/
│   └── com/example/todo_app/
│       └── TodoWidget.kt              # Native RemoteViews widget
├── android/app/src/main/res/
│   ├── drawable/                      # Theme wallpapers and drawables
│   └── layout/todo_widget.xml         # Widget layout
├── test/widget_test.dart              # Flutter widget tests
├── pubspec.yaml                       # Flutter dependencies
└── README.md                         # CDN-backed visual documentation
```

## 

<div align="center">

![08 Start The Board](https://img.shields.io/badge/08-START_THE_BOARD-FF4D6D?style=for-the-badge&labelColor=12101F)

</div>

### Requirements

`Flutter 3.24+` · `Dart 3` · `Android SDK API 34+` · `JDK 17`

### Install dependencies

```bash
flutter pub get
```

### Run on a device or emulator

```bash
flutter run
```

### Build a release APK

```bash
flutter build apk --release
```

The release artifact is written to:

```
build/app/outputs/flutter-apk/app-release.apk
```

For the best experience, install the APK on an Android device, add the **Bounty Board** widget to the home screen, then change themes and font size from inside the app.

## 

<div align="center">

![09 Design Language](https://img.shields.io/badge/09-DESIGN_LANGUAGE-A894E6?style=for-the-badge&labelColor=12101F)

<h2>Productivity, but make it yours.</h2> <p>Dark skies, sharp accents, anime worlds, Japanese motifs, and a task list that feels more like a personal command center than a spreadsheet.</p>
<blockquote><strong>Post the bounty. Face the mission. Claim the win.</strong>  
<sub>offline · personal · always within reach</sub></blockquote> </div>

## License

The Bounty Board is released under the [MIT License](./LICENSE).
