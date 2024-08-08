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
      this.padding = const EdgeInsets.symmetric(horizontal: 16),
      this.validator})
      : _ctrl = ctrl;

  final TextEditingController _ctrl;
  final String hint;
  final String label;
  final TextInputType inputType;
  final bool passwdBox;
  final int mlines;
  final EdgeInsetsGeometry padding;
  final String? Function(String?)? validator;
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
      cursorWidth: 3,
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
