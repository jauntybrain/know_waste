import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bouncing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.onTap,
    required this.icon,
    this.radius,
    this.size,
    this.iconSize,
    this.fillColor,
    this.color,
    super.key,
  });

  final VoidCallback onTap;
  final IconData icon;
  final double? radius, size, iconSize;
  final Color? fillColor, color;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: () => HapticFeedback.lightImpact().then((_) => onTap.call()),
      child: Container(
        width: size ?? 55,
        height: size ?? 55,
        decoration: BoxDecoration(
          color: fillColor ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 18),
          border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
        ),
        child: Icon(
          icon,
          size: iconSize ?? 25,
          color: color ?? const Color(0xff007029),
        ),
      ),
    );
  }
}
