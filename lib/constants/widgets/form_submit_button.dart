import 'package:alivechms/controllers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fullWidth = true,
    this.width = 0,
    this.disabled = false,
    this.icon,
  });

  final void Function()? onTap;
  final String title;
  final bool fullWidth;
  final double width;
  final bool disabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // APP STATE
    var appState = Provider.of<MyAppState>(context);

    // FORM BUTTON
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onTap,
        child: appState.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (icon != null)
                    Icon(
                      icon!,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                ],
              ),
      ),
    );
  }
}
