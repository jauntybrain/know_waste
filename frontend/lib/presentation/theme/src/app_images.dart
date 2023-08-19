import 'package:flutter/material.dart';

class AppImages {
  static const imagesPath = 'assets/images';

  /// Define local assets
  static const String wasteScanner = 'waste-scanner.jpg';
  static const String comingSoon = 'coming-soon.jpg';

  /// Return the image
  static Widget image(
    String path, {
    double? height,
    double? width,
  }) {
    return Image.asset(
      '$imagesPath/$path',
      fit: BoxFit.cover,
      width: height,
      height: width,
    );
  }
}
