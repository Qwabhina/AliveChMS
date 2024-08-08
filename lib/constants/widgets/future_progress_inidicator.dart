// views/profile_page.dart
import 'package:alivechms/constants/app_constants.dart';
import 'package:flutter/material.dart';

class FutureProgressIndicator extends StatelessWidget {
  const FutureProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.primaryBlue
                : AppColors.primaryGold,
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
