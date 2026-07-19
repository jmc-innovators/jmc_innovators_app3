import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class _Entry {
  final String word;
  final String tamil;
  final String sinhala;
  bool bookmarked;
  _Entry(this.word, this.tamil, this.sinhala, {this.bookmarked = false});
}

/// English / Tamil / Sinhala dictionary. Word list is mock data — replace
/// with a bundled offline dataset (JSON/SQLite) for true offline lookup,
/// and hook a TTS package (flutter_tts) in place of the mic icon for
/// voice pronunciation.
class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});
  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String _query = '';
  final List<_Entry> _entries = [
    _Entry('Photosynthesis', 'ஒளிச்சேர்க்கை', 'ප්‍රභාසංස්ලේෂණය'),
    _Entry('Gravity', 'ஈர்ப்பு விசை', 'ගුරුත්වාකර්ෂණය'),
    _Entry('Democracy', 'ஜனநாயகம்', 'ප්‍රජාතන්ත්‍රවාදය'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _entries.where((e) => e.word.toLowerCase().contains(_query.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Dictionary')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(hintText: 'Search a word...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final e = filtered[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.word, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              Text('${e.tamil}  ·  ${e.sinhala}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.volume_up_rounded, color: AppColors.cyan), onPressed: () {}),
                        IconButton(
                          icon: Icon(e.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: e.bookmarked ? AppColors.cyan : AppColors.textSecondary),
                          onPressed: () => setState(() => e.bookmarked = !e.bookmarked),
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
}
