import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

/// Placeholder shells for Chemistry/Physics/Biology simulators.
/// Each card should open a dedicated interactive widget (or a WebView
/// pointing at an existing PhET-style simulation) — kept as a nav
/// target here so the section is wired end-to-end.
class ScienceLabScreen extends StatelessWidget {
  const ScienceLabScreen({super.key});

  static const _labs = [
    ('Chemistry Simulator', Icons.science_rounded),
    ('Physics Simulator', Icons.bolt_rounded),
    ('Biology Animations', Icons.biotech_rounded),
    ('Virtual Lab Activities', Icons.emoji_objects_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Science Lab')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _labs.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            onTap: () {},
            child: Row(
              children: [
                Icon(_labs[i].$2, color: AppColors.purple, size: 28),
                const SizedBox(width: 12),
                Expanded(child: Text(_labs[i].$1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
