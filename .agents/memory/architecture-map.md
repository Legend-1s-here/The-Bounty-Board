# Architecture Map

## Repository Shape

```
To do list/
├── lib/
│   ├── main.dart                  # Flutter entry point, Hive init & home_widget callback
│   ├── models/
│   │   ├── task.dart              # Task model Hive schema
│   │   └── task.g.dart            # Hive TypeAdapter implementation
│   ├── providers/
│   │   └── task_provider.dart     # ChangeNotifier state manager + widget data synchronizer
│   ├── screens/
│   │   ├── home_screen.dart       # Main UI with SliverAppBar, Filter chips, Task list
│   │   └── add_task_screen.dart   # Task creation modal bottom sheet
│   └── widgets/
│       └── task_tile.dart         # Task item UI with swipe-to-delete & animated completion checkbox
│
├── android/
│   ├── app/src/main/
│   │   ├── kotlin/com/example/todo_app/
│   │   │   ├── MainActivity.kt        # FlutterActivity host
│   │   │   ├── TodoWidget.kt          # Android AppWidgetProvider
│   │   │   └── TodoWidgetService.kt   # RemoteViewsService & Factory for widget ListView
│   │   ├── res/
│   │   │   ├── layout/
│   │   │   │   ├── todo_widget.xml        # Widget container layout
│   │   │   │   └── widget_task_item.xml   # Widget list item layout
│   │   │   ├── drawable/                  # Widget shapes & button backgrounds
│   │   │   └── xml/todo_widget_info.xml   # AppWidgetProviderInfo configuration
│   │   └── AndroidManifest.xml        # Declares Activity, Widget receiver & RemoteViews service
│   ├── build.gradle                   # Root Gradle build config
│   └── settings.gradle                # Gradle settings & plugin loader
│
├── .agents/                           # Antigravity SDLC governance & memory bank
├── pubspec.yaml                       # Flutter dependencies (hive, provider, home_widget, uuid)
└── README.md
```

## Key Flows
1. **Task Modification Flow**: User adds/toggles task in UI -> `TaskProvider` updates Hive box -> `TaskProvider._updateWidget()` writes active task titles into `HomeWidgetPlugin` SharedPreferences -> `HomeWidget.updateWidget()` calls Android native broadcast to refresh the home screen widget.
2. **Widget Launch Flow**: User taps `+` on home screen widget -> Launches `MainActivity` with `ADD_TASK` Intent -> opens task entry bottom sheet.
