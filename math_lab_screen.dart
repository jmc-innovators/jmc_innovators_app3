import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart' as me;
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

/// A working calculator (via math_expressions) plus nav targets for
/// graphing, geometry tools, and formula explorer, which are better
/// built with a dedicated charting/geometry package once scoped.
class MathLabScreen extends StatefulWidget {
  const MathLabScreen({super.key});
  @override
  State<MathLabScreen> createState() => _MathLabScreenState();
}

class _MathLabScreenState extends State<MathLabScreen> {
  final _exprCtrl = TextEditingController();
  String _result = '';

  void _evaluate() {
    try {
      final parser = me.Parser();
      final exp = parser.parse(_exprCtrl.text);
      final result = exp.evaluate(me.EvaluationType.REAL, me.ContextModel());
      setState(() => _result = '$result');
    } catch (_) {
      setState(() => _result = 'Invalid expression');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Math Lab')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GlassCard(
              child: Column(
                children: [
                  TextField(
                    controller: _exprCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(hintText: 'e.g. 2*(3+4)^2', border: InputBorder.none),
                    onSubmitted: (_) => _evaluate(),
                  ),
                  const Divider(color: Colors.white24),
                  Align(alignment: Alignment.centerLeft, child: Text(_result, style: const TextStyle(color: AppColors.cyan, fontSize: 20))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _evaluate, child: const Text('Calculate'))),
            const SizedBox(height: 20),
            _navTile('Graph Explorer', Icons.show_chart_rounded),
            _navTile('Geometry Tools', Icons.category_rounded),
            _navTile('Practice Problems', Icons.assignment_rounded),
          ],
        ),
      ),
    );
  }

  Widget _navTile(String label, IconData icon) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: GlassCard(
          onTap: () {},
          child: Row(children: [
            Icon(icon, color: AppColors.purple),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(color: Colors.white))),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ]),
        ),
      );
}
