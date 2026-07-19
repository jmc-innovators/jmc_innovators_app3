import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class Note {
  String title;
  String body;
  bool pinned;
  Note({required this.title, required this.body, this.pinned = false});
}

/// Notes here live in memory for this scaffold. Wire this up to Hive
/// (already in pubspec) for offline persistence, and mirror writes to
/// Firestore under users/{uid}/notes for cross-device sync.
class NotebookScreen extends StatefulWidget {
  const NotebookScreen({super.key});

  @override
  State<NotebookScreen> createState() => _NotebookScreenState();
}

class _NotebookScreenState extends State<NotebookScreen> {
  final List<Note> _notes = [
    Note(title: 'Photosynthesis summary', body: 'Light + CO2 + water -> glucose + O2', pinned: true),
    Note(title: 'Algebra formulas', body: 'Quadratic formula: (-b ± sqrt(b²-4ac)) / 2a'),
  ];
  String _query = '';

  void _openEditor({Note? note}) {
    final titleCtrl = TextEditingController(text: note?.title ?? '');
    final bodyCtrl = TextEditingController(text: note?.body ?? '');
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(hintText: 'Title')),
            const SizedBox(height: 12),
            TextField(controller: bodyCtrl, maxLines: 5, decoration: const InputDecoration(hintText: 'Note...')),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (note == null) {
                      _notes.add(Note(title: titleCtrl.text, body: bodyCtrl.text));
                    } else {
                      note.title = titleCtrl.text;
                      note.body = bodyCtrl.text;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _notes.where((n) =>
        n.title.toLowerCase().contains(_query.toLowerCase()) ||
        n.body.toLowerCase().contains(_query.toLowerCase())).toList()
      ..sort((a, b) => (b.pinned ? 1 : 0).compareTo(a.pinned ? 1 : 0));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('AI Smart Notebook')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _openEditor(), backgroundColor: AppColors.cyan, child: const Icon(Icons.add, color: Colors.black)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(hintText: 'Search notes...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final note = filtered[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    onTap: () => _openEditor(note: note),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(note.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(note.body, maxLines: 2, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(note.pinned ? Icons.push_pin : Icons.push_pin_outlined,
                              color: note.pinned ? AppColors.cyan : AppColors.textSecondary),
                          onPressed: () => setState(() => note.pinned = !note.pinned),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                          onPressed: () => setState(() => _notes.remove(note)),
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
