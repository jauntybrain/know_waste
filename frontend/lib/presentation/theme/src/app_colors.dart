import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff15CD27);

  static const Color primaryDark = Color(0xff001D3D);

  static const Color secondary = Color(0xff008732);

  static const Color secondaryDark = Color(0xff007029);

  static const Color red = Color(0xFFC74C4C);

  static const Color text = Color(0xff121212);

  static const Color subtitle = Color(0xff606060);

  static const Color background = Color(0xfff9f9f9);

  static const Color white = Color(0xffffffff);

  static const Color lightGray = Color(0xffcccccc);

  static const Color backgroundDark = Color(0xff000814);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [primary, primaryDark],
  );
}
