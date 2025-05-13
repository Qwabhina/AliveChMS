import 'package:flutter/material.dart';

class FormTextBox extends StatelessWidget {
  const FormTextBox(
      {super.key,
      required TextEditingController ctrl,
      required this.inputType,
      required this.label,
      this.icon = const SizedBox(),
      this.hint = "",
      this.passwdBox = false,
      this.mlines = 1,
      this.autoFocus = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 16),
      this.validator,
      this.onFieldSubmitted})
      : _ctrl = ctrl;

  final TextEditingController _ctrl;
  final String hint;
  final String label;
  final TextInputType inputType;
  final bool passwdBox;
  final int mlines;
  final bool autoFocus;
  final EdgeInsetsGeometry padding;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _ctrl,
      obscureText: passwdBox,
      keyboardType: inputType,
      maxLines: mlines,
      autofocus: autoFocus,
      cursorWidth: 3,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        suffixIcon: icon,
        // icon: icon,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        // label: Text(label),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(fontStyle: FontStyle.italic),
        contentPadding: padding,
        border: const OutlineInputBorder(
          gapPadding: 10,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
