import 'package:flutter/material.dart';

class PageSectionHeader extends StatelessWidget {
  const PageSectionHeader({
    super.key,
    String text = '',
    FontWeight fontWeight = FontWeight.bold,
    TextAlign textAlign = TextAlign.left,
    double fontSize = 16,
  })  : _text = text,
        _fontWeight = fontWeight,
        _textAlign = textAlign,
        _fontSize = fontSize;

  final String _text;
  final TextAlign _textAlign;
  final FontWeight _fontWeight;
  final double _fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          color: Theme.of(context).colorScheme.primaryContainer),
      textAlign: _textAlign,
    );
  }
}
