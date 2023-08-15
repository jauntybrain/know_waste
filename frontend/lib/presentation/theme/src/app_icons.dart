import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static const iconsPath = 'assets/icons';

  /// Define local assets
  static const String logoHorizontal = 'logo-horizontal.svg';
  static const String wasteScanner = 'waste-scanner.svg';
  static const String comingSoon = 'coming-soon.svg';
  static const String advice = 'advice.svg';
  static const String tips = 'tips.svg';
  static const String local = 'local.svg';
  static const String plastic = 'plastic.svg';
  static const String glass = 'glass.svg';
  static const String paper = 'paper.svg';
  static const String electronics = 'electronics.svg';
  static const String other = 'other.svg';
  static const String signIn = 'sign-in.svg';
  static const String settings = 'settings.svg';
  static const String help = 'help.svg';
  static const String scans = 'scans.svg';
  static const String appleLogo = 'apple.svg';
  static const String googleLogo = 'google.svg';

  /// Check if the icon is vector
  static bool isSvg(String path) => path.contains('svg');

  /// Return the icon
  static Widget icon(
    String path, {
    double? size,
    Color? color,
  }) {
    if (isSvg(path)) {
      return SvgPicture.asset(
        '$iconsPath/$path',
        width: size,
        height: size,
        color: color,
      );
    } else {
      return Image.asset(
        '$iconsPath/$path',
        width: size,
        height: size,
      );
    }
  }
}
