import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class _Paper {
  final String title;
  final String grade;
  final String subject;
  final String medium;
  final String year;
  bool bookmarked;
  _Paper(this.title, this.grade, this.subject, this.medium, this.year, {this.bookmarked = false});
}

class ExamPapersScreen extends StatefulWidget {
  const ExamPapersScreen({super.key});

  @override
  State<ExamPapersScreen> createState() => _ExamPapersScreenState();
}

class _ExamPapersScreenState extends State<ExamPapersScreen> {
  String? _grade, _subject, _medium, _year;
  String _query = '';

  final List<_Paper> _papers = [
    _Paper('Combined Maths Paper I', 'Grade 11', 'Mathematics', 'English', '2024'),
    _Paper('Science Paper II', 'Grade 10', 'Science', 'Sinhala', '2023'),
    _Paper('Tamil Language Paper', 'Grade 9', 'Tamil', 'Tamil', '2024'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _papers.where((p) {
      if (_grade != null && p.grade != _grade) return false;
      if (_subject != null && p.subject != _subject) return false;
      if (_medium != null && p.medium != _medium) return false;
      if (_year != null && p.year != _year) return false;
      if (_query.isNotEmpty && !p.title.toLowerCase().contains(_query.toLowerCase())) return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Exam Papers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(hintText: 'Search papers...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _filterChip('Grade', ['Grade 9', 'Grade 10', 'Grade 11'], _grade, (v) => setState(() => _grade = v)),
                _filterChip('Subject', ['Mathematics', 'Science', 'Tamil'], _subject, (v) => setState(() => _subject = v)),
                _filterChip('Medium', ['English', 'Sinhala', 'Tamil'], _medium, (v) => setState(() => _medium = v)),
                _filterChip('Year', ['2023', '2024'], _year, (v) => setState(() => _year = v)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final p = filtered[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf_rounded, color: AppColors.cyan),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              Text('${p.grade} · ${p.subject} · ${p.medium} · ${p.year}',
                                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(p.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: p.bookmarked ? AppColors.cyan : AppColors.textSecondary),
                          onPressed: () => setState(() => p.bookmarked = !p.bookmarked),
                        ),
                        IconButton(
                          icon: const Icon(Icons.download_rounded, color: AppColors.textSecondary),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, List<String> options, String? selected, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String?>(
        onSelected: onChanged,
        itemBuilder: (context) => [
          const PopupMenuItem(value: null, child: Text('All')),
          ...options.map((o) => PopupMenuItem(value: o, child: Text(o))),
        ],
        child: Chip(
          label: Text(selected ?? label),
          backgroundColor: selected != null ? AppColors.cyan : AppColors.surfaceGlass,
          labelStyle: TextStyle(color: selected != null ? Colors.black : Colors.white70),
        ),
      ),
    );
  }
}
