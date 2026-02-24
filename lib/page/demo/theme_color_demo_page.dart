import 'package:flutter/material.dart';

import '../../app/config/app_theme.dart';

class ThemeColorDemoPage extends StatelessWidget {
  const ThemeColorDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorScheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('主题色示例')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('主题色预览', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ColorItem(
                  color: AppTheme.lightColors.mainColor,
                  selected: colors.mainColor ==
                      AppTheme.lightColors.mainColor,
                  label: '浅色',
                ),
                _ColorItem(
                  color: AppTheme.darkColors.mainColor,
                  selected:
                      colors.mainColor == AppTheme.darkColors.mainColor,
                  label: '深色',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('示例组件', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text('主按钮'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('次按钮'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: colors.mainColor),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('这里是使用主题色的示例内容。'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  final Color color;
  final bool selected;
  final String? label;

  const _ColorItem({
    required this.color,
    required this.selected,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderColor = selected ? scheme.onPrimary : scheme.outline;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: selected
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : null,
        ),
        if (label != null) ...[
          const SizedBox(height: 6),
          Text(label!, style: Theme.of(context).textTheme.labelSmall),
        ],
      ],
    );
  }
}
