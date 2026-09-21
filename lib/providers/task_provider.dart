import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_widget/home_widget.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

const String _widgetName = 'TodoWidget';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  String _filter = 'all'; // 'all' | 'active' | 'completed'

  List<Task> get tasks {
    switch (_filter) {
      case 'active':
        return _tasks.where((t) => !t.isCompleted).toList();
      case 'completed':
        return _tasks.where((t) => t.isCompleted).toList();
      default:
        return List.unmodifiable(_tasks);
    }
  }

  String get filter => _filter;

  int get activeCount => _tasks.where((t) => !t.isCompleted).length;
  int get completedCount => _tasks.where((t) => t.isCompleted).length;

  Box<Task> get _box => Hive.box<Task>('tasks');

  // Load tasks from Hive on startup
  void loadTasks() {
    _tasks = _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
    _updateWidget();
  }

  // Add a new task
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    final task = Task(
      id: const Uuid().v4(),
      title: title.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    await _box.put(task.id, task);
    _tasks.insert(0, task);
    notifyListeners();
    _updateWidget();
  }

  // Toggle task completion
  Future<void> toggleTask(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    await _tasks[index].save();
    notifyListeners();
    _updateWidget();
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    await _box.delete(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
    _updateWidget();
  }

  // Set filter
  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  // Clear all completed tasks
  Future<void> clearCompleted() async {
    final completed = _tasks.where((t) => t.isCompleted).toList();
    for (final task in completed) {
      await _box.delete(task.id);
    }
    _tasks.removeWhere((t) => t.isCompleted);
    notifyListeners();
    _updateWidget();
  }

  /// Push latest task data to the Android home screen widget.
  Future<void> _updateWidget() async {
    try {
      final pending = _tasks.where((t) => !t.isCompleted).toList();
      final taskTitles = pending.take(5).map((t) => t.title).join('|');

      await HomeWidget.saveWidgetData<String>('task_titles', taskTitles);
      await HomeWidget.saveWidgetData<int>('active_count', pending.length);
      await HomeWidget.saveWidgetData<int>(
        'extra_count',
        pending.length > 5 ? pending.length - 5 : 0,
      );
      await HomeWidget.updateWidget(
        name: _widgetName,
        androidName: _widgetName,
        iOSName: _widgetName,
        qualifiedAndroidName: 'com.example.todo_app.$_widgetName',
      );
    } catch (e) {
      // Widget update not critical — ignore on non-Android platforms
      debugPrint('Widget update skipped: $e');
    }
  }
}
