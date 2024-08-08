import 'package:alivechms/screens/contributions/contributions_screen.dart';
import 'package:alivechms/screens/dashboard/homepage.dart';
import 'package:alivechms/screens/events/events_screen.dart';
import 'package:alivechms/screens/finance/finance_screen.dart';
import 'package:alivechms/screens/groups/groups_screen.dart';
import 'package:alivechms/screens/members/members_screen.dart';
import 'package:alivechms/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  bool isLoading = false;
  bool isLoggedIn = false;
  bool isPasswordVisible = false;
  String errorMessage = '';
  String currentPage = 'Dashboard';
  int selectedIndex = 0;
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

  
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    if (isPasswordVisible) {
      isPasswordVisible = false;
    } else {
      isPasswordVisible = true;
    }
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void loginSuccess() {
    isLoggedIn = true;
    stopLoading();
    notifyListeners();
  }

  void loginFailed(String error) {
    isLoggedIn = false;
    errorMessage = error;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    setCurrentPage(0, 'profile');
    notifyListeners();
  }



  void setCurrentPage(int index, String title) {
    selectedIndex = index;
    currentPage = title;
    notifyListeners();
  }

  final List<Widget> drawerPages = <Widget>[
    const HomepageScreen(),
    const MembersPage(),
    const GroupsScreen(),
    const ContributionsScreen(),
    const EventsScreen(),
    const FinancePage(),
    const SettingsPage(),
  ];
}
