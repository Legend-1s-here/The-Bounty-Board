import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<TaskProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.onError),
      ),
      onDismissed: (_) => provider.deleteTask(task.id),
      child: Card(
        elevation: 0,
        color: task.isCompleted
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
            : theme.colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: GestureDetector(
            onTap: () => provider.toggleTask(task.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isCompleted
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                  width: 2,
                ),
                color: task.isCompleted
                    ? theme.colorScheme.primary
                    : Colors.transparent,
              ),
              child: task.isCompleted
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: theme.colorScheme.onPrimary,
                    )
                  : null,
            ),
          ),
          title: Text(
            task.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: (themeProvider.fontSizeSp + 2).toDouble(),
              decoration:
                  task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                  : theme.colorScheme.onSurface,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            color: theme.colorScheme.error.withValues(alpha: 0.6),
            onPressed: () => provider.deleteTask(task.id),
          ),
        ),
      ),
    );
  }
}
