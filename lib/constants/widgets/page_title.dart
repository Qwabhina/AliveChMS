import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.pageName,
    double textSize = 24,
  }) : _textSize = textSize;

  final String pageName;
  final double _textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      pageName,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primaryContainer,
        fontSize: _textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
