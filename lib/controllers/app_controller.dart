import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AppController {
  // // THE BOX NAME FOR THE LOCAL STORAGE
  // static late Box appBox;

  // // INITIALIZE APP SETTINGS
  // static initApp() async {
  //   await Hive.initFlutter();
  //   return Hive.openBox('aspBox');
  // }

  // // RETRIEVE USER'S TOKEN FROM THE LOCAL STORAGE
  // static String get userToken => aspBox.get('userToken', defaultValue: '');

  // // SET FIRST RUN VALUE SINCE USER HAS RUN THE APP
  // static void setFirstRun() {
  //   aspBox.put('firstRun', 1);
  // }

  // // DETERMINE IF ITS FIRST TIME RUNNIG APP
  // static bool isFirstRun = aspBox.get(
  //           "firstRun",
  //           defaultValue: 0,
  //         ) ==
  //         1
  //     ? false
  //     : true;

  // // CHECK IF USER HAS LOGGED IN BEFORE
  // static bool get userExists => aspBox.keys.contains('user') ? true : false;

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
  static final Map<String, IconData> _dialogIcons = {
    "success": Icons.check_circle_outline_rounded,
    "error": Icons.cancel_outlined,
    "info": Icons.info_outline_rounded,
    "warning": Icons.warning_amber_rounded,
  };

//SHOW CUSTOM [ALERT] DIALOG
  static showAlert(
    BuildContext ctx,
    String message,
    String type, {
    bool onTop = false,
  }) {
    return showDialog(
        barrierDismissible: onTop,
        useSafeArea: true,
        context: ctx,
        builder: (c) {
          return Center(
            child: Container(
              width: MediaQuery.of(c).size.width * 0.8,
              height: MediaQuery.of(c).size.height * 0.4,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Theme.of(c).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Icon(
                        _dialogIcons[type],
                        color: _dialogColors[type],
                        size: 60,
                      ),
                    ),
                    // const Spacer(),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(c)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(c).colorScheme.onSurface),
                    ),
                    // const Spacer(),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _dialogColors[type],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: _dialogColors[type]!,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () => Navigator.pop(c),
                        child: const Text(
                          "Ok",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
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
