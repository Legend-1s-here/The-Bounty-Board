import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'font_size_sheet.dart';
import 'theme_picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<Uri?>? _widgetClickSubscription;

  @override
  void initState() {
    super.initState();
    _checkLaunchedFromWidget();
    _widgetClickSubscription =
        HomeWidget.widgetClicked.listen(_handleWidgetClick);
  }

  @override
  void dispose() {
    _widgetClickSubscription?.cancel();
    super.dispose();
  }

  void _checkLaunchedFromWidget() async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    _handleWidgetClick(uri);
  }

  void _handleWidgetClick(Uri? uri) {
    if (uri != null && uri.host == 'addTask' && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAddTaskSheet(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final currentTheme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────
          SliverAppBar.large(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentTheme.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Bounty Board',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              // Font Size button
              IconButton(
                icon: const Icon(Icons.format_size_rounded),
                tooltip: 'Font Size',
                onPressed: () => _showFontSizePicker(context),
              ),
              // Theme Picker button
              IconButton(
                icon: const Icon(Icons.palette_outlined),
                tooltip: 'Change Theme',
                onPressed: () => _showThemePicker(context),
              ),
              if (provider.completedCount > 0)
                TextButton.icon(
                  onPressed: () => _confirmClearCompleted(context, provider),
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: const Text('Clear done'),
                ),
              const SizedBox(width: 4),
            ],
          ),

          // ── Stats bar ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  _StatChip(
                    label: '${provider.activeCount} active',
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  _StatChip(
                    label: '${provider.completedCount} claimed',
                    color: theme.colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ),

          // ── Filter chips ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  _FilterChip(label: 'All', value: 'all', provider: provider),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Active', value: 'active', provider: provider),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Claimed',
                    value: 'completed',
                    provider: provider,
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // ── Task list ────────────────────────────────────────────
          provider.tasks.isEmpty
              ? SliverFillRemaining(
                  child: _EmptyState(
                    filter: provider.filter,
                    emoji: currentTheme.emoji,
                  ),
                )
              : SliverList.separated(
                  itemCount: provider.tasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TaskTile(task: task),
                    );
                  },
                ),
        ],
      ),

      // ── FAB: Add Bounty ───────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Bounty'),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const AddTaskScreen(),
    );
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<ThemeProvider>(),
        child: const ThemePickerScreen(),
      ),
    );
  }

  void _showFontSizePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<ThemeProvider>(),
        child: const FontSizeSheet(),
      ),
    );
  }

  void _confirmClearCompleted(BuildContext context, TaskProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear claimed bounties?'),
        content: Text(
          'Remove ${provider.completedCount} claimed bounty(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              provider.clearCompleted();
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

// ── Helper Widgets ────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final TaskProvider provider;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.filter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => provider.setFilter(value),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String filter;
  final String emoji;

  const _EmptyState({required this.filter, required this.emoji});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = switch (filter) {
      'active' => 'No active bounties!\nAll bounties claimed 🎉',
      'completed' => 'No claimed bounties yet.\nStart completing tasks!',
      _ => 'The board is empty!\nTap + to post your first bounty.',
    };

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
