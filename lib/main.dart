import 'package:alivechms/constants/color_scheme.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/screens/dashboard/dashboard_screen.dart';
import 'package:alivechms/screens/login/login_screen.dart';
import 'package:alivechms/screens/onboarding_screen.dart';
import 'package:alivechms/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
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
          //         ? const ProfilePage()
          //         : const LoginPage()),
          home: const DashboardScreen(),

          // NAVIGATION
          navigatorKey: myAppState.navigatorKey,
          routes: {
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const DashboardScreen(),
            // '/forgotPass': (context) => const ForgotPasswordPage(),
            // '/resetPass': (context) => ResetPasswordPage(),
            // '/changePassword': (context) => ChangePasswordPage(),
            // '/profile': (context) => const ProfilePage(),
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
