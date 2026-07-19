import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

/// Native reimplementation of the JMC Classroom feature set. Data here is
/// mock/local — swap each tab's list for a Firestore query (or a call into
/// the existing JMC Classroom web app's data layer) once that's wired up.
class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 5, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('JMC Classroom'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          indicatorColor: AppColors.cyan,
          labelColor: AppColors.cyan,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'Announcements'),
            Tab(text: 'Assignments'),
            Tab(text: 'Quizzes'),
            Tab(text: 'Grades'),
            Tab(text: 'Attendance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _list(['New syllabus posted', 'Parent meeting on Friday'], Icons.campaign_rounded),
          _list(['Essay: Climate Change (due Mon)', 'Problem Set 4 (due Wed)'], Icons.assignment_rounded),
          _list(['Chapter 3 Quiz — open', 'Midterm review quiz'], Icons.quiz_rounded),
          _list(['Maths: A', 'Science: A-', 'English: B+'], Icons.grade_rounded),
          _list(['Present — Mon', 'Present — Tue', 'Absent — Wed'], Icons.event_available_rounded),
        ],
      ),
    );
  }

  Widget _list(List<String> items, IconData icon) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GlassCard(
          child: Row(
            children: [
              Icon(icon, color: AppColors.cyan),
              const SizedBox(width: 12),
              Expanded(child: Text(items[i], style: const TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
