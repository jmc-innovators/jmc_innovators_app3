import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Tell Us')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GlassCard(
          child: Column(
            children: [
              TextField(controller: _nameCtrl, decoration: const InputDecoration(hintText: 'Your name')),
              const SizedBox(height: 12),
              TextField(controller: _messageCtrl, maxLines: 4, decoration: const InputDecoration(hintText: 'Your message')),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Message sent — thank you!')));
                    _nameCtrl.clear();
                    _messageCtrl.clear();
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
