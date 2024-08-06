import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class ImgLinks {
  static final logoDark = Image.asset('assets/img/Logo_Dark.png');
  static final logoLight = Image.asset('assets/img/Logo_Light.png');
  static final logoMono = Image.asset('assets/img/Logo_White.png');
  static const String onboardBeginImg = "assets/onboard_img_fade.png";
  // static const String onboardBeginImg = "assets/onboard_begin_img.jpg";
  static const String onboardEndImg = "assets/onboard_img2_fade.png";
  // static const String onboardEndImg = "assets/onboard_end_img.jpg";
}

class AppColors {
  static Color mainLightBg = const Color(0xFFF0F0F0);
  static Color lightBorder = const Color(0xFF666666);
  static Color primaryBlue = const Color(0xFF020066);
  static Color accentBlue = const Color.fromARGB(255, 0, 73, 141);
  static Color primaryGold = const Color(0xFFE5A100);
  static Color primaryRed = const Color(0xFFF50000);

  static final buttonColors = WindowButtonColors(
    iconNormal: primaryBlue,
    mouseOver: primaryBlue,
    mouseDown: const Color.fromARGB(255, 1, 0, 68),
    iconMouseOver: mainLightBg,
    iconMouseDown: primaryGold,
  );

  static final closeButtonColors = WindowButtonColors(
    mouseOver: primaryRed,
    mouseDown: const Color.fromARGB(255, 167, 0, 0),
    iconNormal: primaryBlue,
    iconMouseOver: mainLightBg,
  );
}
