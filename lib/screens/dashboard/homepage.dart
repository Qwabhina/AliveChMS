import 'package:alivechms/screens/dashboard/dashboard_highlights.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(children: [
        const PageSectionHeader(text: 'Overview'),
        const SizedBox(height: 16),
        const DashboardHighlights(),
        const SizedBox(height: 24),
        const PageSectionHeader(text: 'Recent Member Registrations'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ]),
    );
  }
}

class PageSectionHeader extends StatelessWidget {
  const PageSectionHeader({super.key, String text = ''}) : _text = text;

  final String _text;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primaryContainer),
    );
  }
}
