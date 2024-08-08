import 'package:alivechms/constants/app_constants.dart';
import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "appLogo",
      child: Theme.of(context).brightness == Brightness.light
          ? ImgLinks.logoLight
          : ImgLinks.logoDark,
    );
  }
}
