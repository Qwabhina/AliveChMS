import 'dart:io';

import 'package:alivechms/constants/color_scheme.dart';
import 'package:alivechms/controllers/app_controller.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/screens/dashboard/dashboard_screen.dart';
import 'package:alivechms/screens/login/login_screen.dart';
import 'package:alivechms/screens/onboarding/onboarding_screen.dart';
import 'package:alivechms/screens/profile/profile_screen.dart';
import 'package:alivechms/screens/settings/settings_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

// OPEN THE HIVE DB
late Box aspBox;

void main() async {
  // INITIALIZE APP SETTINGS
  aspBox = await AppController.initApp();

  // ENSURE APP IS FULLY INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MainApp());

  // SHOW WINDOW WITH CUSTOMIZED TITLE BAR
  if (Platform.isWindows || Platform.isMacOS) {
    doWhenWindowReady(() {
      appWindow.size = const Size(1280, 720);
      appWindow.minSize = const Size(1280, 720);
      appWindow.alignment = Alignment.center;
      appWindow.title = "AliveChMS";

      windowManager.ensureInitialized();
      windowManager.show();
      windowManager.maximize();
      windowManager.focus();
    });
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: Consumer<MyAppState>(builder: (context, myAppState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AliveChMS',

          // APP THEME
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            // textTheme: GoogleFonts.syste(),
          ),

          // DARK THEME
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            // textTheme: GoogleFonts.openSansTextTheme(),
          ),

          themeMode: myAppState.appThemeMode,

          // INITIAL PAGE (SPLASHSCREEN)
          // home: AppController.isFirstRun
          //     ? const OnboardingScreen()
          //     : (AppController.userExists
          //         ? const DashboardScreen()
          //         : const LoginPage()),
          home: AppController.userExists
              ? const DashboardScreen()
              : const LoginPage(),

          // NAVIGATION
          navigatorKey: myAppState.navigatorKey,
          routes: {
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const DashboardScreen(),
            // '/forgotPass': (context) => const ForgotPasswordPage(),
            // '/resetPass': (context) => ResetPasswordPage(),
            // '/changePassword': (context) => ChangePasswordPage(),
            '/profile': (context) => const ProfilePage(),
            // '/registration': (context) => const RegistrationPage(),
            '/settings': (context) => const SettingsPage(),
            '/onboarding': (context) => const OnboardingScreen(),
            // '/medicals': (context) => const MedicalsPage(),
          },
        );
      }),
    );
  }
}
