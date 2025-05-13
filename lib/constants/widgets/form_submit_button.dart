import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fullWidth = true,
    this.width = 0,
    this.disabled = false,
    this.icon,
    this.loading = false,
  });

  final void Function()? onTap;
  final String title;
  final bool fullWidth;
  final double width;
  final bool disabled;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: disabled || loading ? null : onTap,
        child: loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: textColor,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Loading...',
                    style: TextStyle(color: textColor),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(width: 10),
                  if (icon != null)
                    Icon(
                      icon!,
                      color: textColor,
                    ),
                ],
              ),
      ),
    );
  }
}
