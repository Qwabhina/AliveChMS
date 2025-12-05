import 'package:flutter/material.dart';
import 'package:webb_ui/webb_ui.dart';

class WebbUISettingsPage extends StatelessWidget {
  const WebbUISettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacingGrid.spacing(3)),
      child: Center(
        child: Text(
          'Application Settings',
          style: context.typography.headlineLarge,
        ),
      ),
    );
  }
}
