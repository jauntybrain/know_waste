import 'package:flutter/material.dart';

import '../theme/theme.dart';
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
  final dynamic icon;
  final double? radius, size, iconSize;
  final Color? fillColor, color;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: () => onTap.call(),
      child: Container(
        width: size ?? 55,
        height: size ?? 55,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: fillColor ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 18),
          border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
        ),
        child: icon is IconData
            ? Icon(
                icon as IconData,
                size: iconSize ?? 25,
                color: color ?? const Color(0xff007029),
              )
            : icon is String
                ? AppIcons.icon(
                    icon as String,
                    size: iconSize ?? 25,
                    color: color ?? const Color(0xff007029),
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}
