import 'package:flutter/material.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onDoubleTap: () => Navigator.pushNamed(context, '/webb_ui'),
        child: const Text(
          'Groups Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
