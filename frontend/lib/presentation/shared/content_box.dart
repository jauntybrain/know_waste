import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.fillColor,
    this.child,
    Key? key,
  }) : super(key: key);

  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? fillColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xfff2f2f2)),
        color: fillColor ?? AppColors.white,
        boxShadow: [AppShadows.small],
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: child,
    );
  }
}
