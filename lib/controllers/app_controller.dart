import 'package:alivechms/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AppController {
  // THE BOX NAME FOR THE LOCAL STORAGE
  static late Box appBox;

  // INITIALIZE APP SETTINGS
  static initApp() async {
    await Hive.initFlutter();
    return Hive.openBox('aliveChMS');
  }

  // RETRIEVE USER'S TOKEN FROM THE LOCAL STORAGE
  static String get userToken => aspBox.get('access_token', defaultValue: '');

  // SET FIRST RUN VALUE SINCE USER HAS RUN THE APP
  static void setFirstRun() {
    aspBox.put('firstRun', 1);
  }

  // DETERMINE IF ITS FIRST TIME RUNNIG APP
  static bool isFirstRun = aspBox.get(
            "firstRun",
            defaultValue: 0,
          ) ==
          1
      ? false
      : true;

  // CHECK IF USER HAS LOGGED IN BEFORE
  static bool get userExists => aspBox.keys.contains('user') ? true : false;

  // // OPEN URL
  // static Future<void> openLink(url) async {
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  // FORMAT DATETIME OUTPUT
  static String formatDate(DateTime currentDate) {
    String getDay = DateFormat('d').format(currentDate);
    String getMonthYear = DateFormat('MMMM, y').format(currentDate);
    String daySuffix = _getDaySuffix(currentDate.day);

    String output = '$getDay$daySuffix $getMonthYear';

    return output;
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static ucFirst(String str) {
    String ucfirstStr = str[0].toUpperCase() + str.substring(1);
    return ucfirstStr;
  }


// COLORS FOR CUSTOM DIALOG
  static final Map<String, Color> _dialogColors = {
    "success": Colors.green.shade700,
    "error": Colors.red.shade700,
    "info": Colors.blue.shade700,
    "warning": Colors.amber.shade700,
  };

// ICONS FOR CUSTOM DIALOG
  static const Map<String, IconData> _dialogIcons = {
    "success": Icons.check_circle_outline,
    "error": Icons.error_outline,
    "info": Icons.info_outline,
    "warning": Icons.warning_amber_rounded,
  };

//SHOW CUSTOM [ALERT] DIALOG
  static showAlert(
    BuildContext ctx,
    String message,
    String type, {
    bool onTop = false,
    VoidCallback? onClose,
}) {
    final icon = _dialogIcons[type] ?? Icons.info;
    final color = _dialogColors[type] ?? Colors.blue;

    return showDialog(
      barrierDismissible: onTop,
      useSafeArea: true,
      context: ctx,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 60,
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                    ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: color, width: 3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onClose != null) onClose();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  static showToast(
    BuildContext ctx,
    String message,
    String type, {
    String actionLabel = 'Ok',
    action,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 5000),
      backgroundColor: _dialogColors[type],
      content: Text(message),
      action: SnackBarAction(label: actionLabel, onPressed: () => action),
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}
