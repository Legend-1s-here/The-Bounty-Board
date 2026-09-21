import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:home_widget/home_widget.dart';

import 'models/task.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox('settings'); // For theme preference

  // Register home_widget interactivity callback
  HomeWidget.registerInteractivityCallback(backgroundCallback);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()..loadTasks()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const BountyBoardApp(),
    ),
  );
}

/// Called when user taps the widget add-button (deep link)
@pragma('vm:entry-point')
Future<void> backgroundCallback(Uri? uri) async {
  // No background actions needed — taps open the app via deep link
  debugPrint('Widget background callback: $uri');
}

class BountyBoardApp extends StatelessWidget {
  const BountyBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = themeProvider.currentTheme;

    return MaterialApp(
      title: 'The Bounty Board',
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      home: const HomeScreen(),
    );
  }
}
