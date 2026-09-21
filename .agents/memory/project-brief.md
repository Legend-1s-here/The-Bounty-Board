# Project Brief

## What this is
A lightweight, fast, local-first cross-platform To-Do List application built for Android (with an interactive Home Screen Widget) and Windows PC, using Flutter and Hive for persistent on-device storage.

## Core goals
- Fast and seamless task management (Add, Complete, Filter, Delete).
- Android Home Screen Widget displaying top active tasks with a quick-add shortcut.
- Clean Material 3 user interface supporting automatic dark/light system theme.
- 100% offline and local persistence via Hive NoSQL database.

## Explicit non-goals
- No remote cloud sync or authentication (kept simple and local per user requirement).
- No complex multi-layer nested sub-tasks or complex tags.

## Constraints
- Cross-platform Flutter code supporting Android and Windows Desktop.
- Android Home Screen Widget built with native Kotlin `AppWidgetProvider` + `RemoteViewsService` integrated via the `home_widget` plugin.

## Primary users
Users looking for a clean, distraction-free To-Do list with instant access to their tasks directly from their Android phone's home screen.
