import 'package:alivechms/constants/app_constants.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(child: MoveWindow()),
          Row(
            children: [
              MinimizeWindowButton(colors: AppColors.buttonColors),
              appWindow.isMaximized
                  ? RestoreWindowButton(
                      colors: AppColors.buttonColors,
                      onPressed: () => appWindow.maximizeOrRestore(),
                    )
                  : MaximizeWindowButton(
                      colors: AppColors.buttonColors,
                      onPressed: () => appWindow.maximizeOrRestore(),
                    ),
              CloseWindowButton(colors: AppColors.closeButtonColors),
            ],
          )
        ],
      ),
    );
  }
}
