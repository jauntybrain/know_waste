import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_icon_button.dart';
import '../../../theme/theme.dart';
import 'tutorial_dialog.dart';

class WasteAnalysisTopNav extends StatelessWidget {
  const WasteAnalysisTopNav({
    this.blurred = false,
    this.showHelp = true,
    this.onClose,
    this.title,
    super.key,
  });

  final bool blurred, showHelp;
  final Function()? onClose;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: blurred ? ImageFilter.blur(sigmaX: 30, sigmaY: 30) : ImageFilter.blur(),
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 12,
            top: MediaQuery.of(context).viewPadding.top + 6,
          ),
          color: blurred ? AppColors.white.withOpacity(0.9) : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIconButton(
                onTap: () {
                  onClose?.call();
                  GoRouter.of(context).pop();
                },
                size: 45,
                icon: Icons.close,
              ),
              Text(
                title ?? 'Scan Waste',
                style: AppTextStyles.blackBlack22.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              if (showHelp)
                AppIconButton(
                  onTap: () => TutorialDialog.of(context).show(),
                  size: 45,
                  icon: Icons.question_mark_rounded,
                )
              else
                const SizedBox(width: 45),
            ],
          ),
        ),
      ),
    );
  }
}
