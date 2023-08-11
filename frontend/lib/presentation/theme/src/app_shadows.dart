import 'package:flutter/material.dart';

class AppShadows {
  static BoxShadow primary = BoxShadow(
    color: Colors.black.withOpacity(0.3),
    blurRadius: 20,
    spreadRadius: -10,
    offset: const Offset(0, 5),
  );
}
