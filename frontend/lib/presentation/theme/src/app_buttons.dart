// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';

import 'app_colors.dart';
import 'app_shadows.dart';
import 'app_text_styles.dart';

class AppButton extends StatelessWidget {
  AppButton.primary({
    Key? key,
    required this.child,
    this.onTap,
    this.fillColor,
    this.textColor,
    this.highlightColor,
    this.borderRadius = 16,
    this.border,
    this.icon,
    this.height = 55,
    this.width,
    this.isLoading = false,
    this.isDisabled = false,
    this.hasShadow = true,
  })  : decoration = BoxDecoration(
          color: isDisabled
              ? fillColor?.withOpacity(0.2)
              : fillColor ?? (onTap == null ? Colors.grey[300] : AppColors.secondary.withOpacity(isDisabled ? 0.5 : 1)),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isDisabled || !hasShadow ? null : [AppShadows.primary],
          border: border,
        ),
        super(key: key);

  AppButton.secondary({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.icon,
    this.height = 55,
    this.width,
    this.isLoading = false,
    this.isDisabled = false,
    this.hasShadow = true,
  })  : fillColor = null,
        border = null,
        highlightColor = null,
        textColor = AppColors.secondary,
        decoration = BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(width: 1, color: const Color(0xffECECEC)),
        ),
        super(key: key);

  final VoidCallback? onTap;
  final Widget? child;
  final Color? fillColor;
  final Color? textColor;
  final Color? highlightColor;
  final double borderRadius;
  final BoxDecoration decoration;
  final String? icon;
  final Border? border;
  final bool isLoading;
  final bool isDisabled;
  final bool hasShadow;

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Bouncing(
          onTap: isLoading || isDisabled ? null : () => onTap?.call(),
          child: SizedBox(
            height: height,
            width: width,
            child: Container(
              decoration: decoration,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width == height ? 0 : 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (child != null)
                      isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(15),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            )
                          : Expanded(
                              flex: icon != null ? 1 : 0,
                              child: Center(
                                child: DefaultTextStyle.merge(
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.blackBold16.copyWith(color: textColor ?? AppColors.white),
                                  child: child!,
                                ),
                              ),
                            ),
                    if (icon != null && child != null)
                      const SizedBox(
                        width: 10,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
