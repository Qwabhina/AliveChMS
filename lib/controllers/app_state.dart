import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  bool isLoading = false;
  bool isLoggedIn = false;
  bool isPasswordVisible = false;
  String errorMessage = '';
  String currentPage = 'profile';
  // StudentData? get currentUser => StudentData.fromMap(aspBox.get('user'));
  ThemeMode get appThemeMode => getAppTheme();

  Map<String, ThemeMode> themes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
    'system': ThemeMode.system
  };

  // NAVIGATOR STATE
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode getAppTheme() {
    // var theme = aspBox.get('theme', defaultValue: 'system');
    // return themes[theme]!;
    return ThemeMode.light;
  }
}
