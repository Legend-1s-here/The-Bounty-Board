import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class FontSizeSheet extends StatelessWidget {
  const FontSizeSheet({super.key});

  static const List<({int sp, String name, String subtitle, String icon})> options = [
    (sp: 11, name: 'Small', subtitle: 'Compact — fits more tasks on widget', icon: 'S'),
    (sp: 13, name: 'Medium (Default)', subtitle: 'Balanced size with great readability', icon: 'M'),
    (sp: 15, name: 'Large', subtitle: 'Larger text for comfortable reading', icon: 'L'),
    (sp: 17, name: 'Extra Large', subtitle: 'Maximum text size on widget and app', icon: 'XL'),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final currentSp = themeProvider.fontSizeSp;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Row(
            children: [
              const Text('🔤', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(
                'Widget & App Font Size',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Tasks wrap onto multiple lines automatically. Choose your preferred text size:',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),

          // Options list
          ...options.map((opt) {
            final isSelected = currentSp == opt.sp;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    themeProvider.setFontSize(opt.sp);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primaryContainer.withValues(alpha: 0.6)
                          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? colorScheme.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Icon circle
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.surfaceContainerHighest,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            opt.icon,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Title & subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                opt.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                opt.subtitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Selection indicator
                        if (isSelected)
                          Icon(
                            Icons.check_circle_rounded,
                            color: colorScheme.primary,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          // Live Preview Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.visibility_outlined, size: 16, color: colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Live Widget Preview (${currentSp}sp)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 8),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Make an app for lab codes for all without sign in just with one tap on phone',
                        style: TextStyle(
                          fontSize: currentSp.toDouble(),
                          height: 1.3,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
