import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class TextbooksScreen extends StatefulWidget {
  const TextbooksScreen({super.key});
  @override
  State<TextbooksScreen> createState() => _TextbooksScreenState();
}

class _TextbooksScreenState extends State<TextbooksScreen> {
  String _query = '';
  final _books = const [
    'Mathematics - Grade 10', 'Science - Grade 10', 'English - Grade 9',
    'ICT - Grade 11', 'History - Grade 8', 'Sinhala - Grade 7',
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _books.where((b) => b.toLowerCase().contains(_query.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Textbooks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(hintText: 'Search textbooks...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 0.75,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, i) => GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(gradient: AppColors.aurora, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.menu_book_rounded, color: Colors.black, size: 36),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(filtered[i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600), maxLines: 2),
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.textSecondary), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.download_outlined, size: 18, color: AppColors.textSecondary), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.favorite_border, size: 18, color: AppColors.textSecondary), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
