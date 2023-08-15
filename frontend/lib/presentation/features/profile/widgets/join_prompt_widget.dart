import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';

import '../../../shared/app_toast.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';

class JoinPromptWidget extends ConsumerWidget {
  const JoinPromptWidget({
    required this.openRegistration,
    required this.openLogin,
    super.key,
  });

  final void Function() openRegistration, openLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppShadows.small],
        border: Border.all(color: const Color(0xfff2f2f2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 20),
          children: [
            Text(
              'Join today',
              textAlign: TextAlign.start,
              style: AppTextStyles.blackBlack22.copyWith(fontSize: 21.5),
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: 350,
              child: Text(
                'Unlock full potential with a free account.',
                textAlign: TextAlign.start,
                style: AppTextStyles.grayMedium16.copyWith(
                  color: const Color(0xffAEAEAE),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton.primary(
                  onTap: openRegistration,
                  height: 50,
                  width: 220,
                  fillColor: AppColors.secondary.withOpacity(0.1),
                  textColor: AppColors.secondary,
                  hasShadow: false,
                  child: const Text('Continue with email'),
                ),
                Container(height: 20, width: 1, color: Colors.black.withOpacity(0.1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bouncing(
                      onTap: () {
                        AppToast.of(context).show(
                          icon: Icons.person_rounded,
                          gravity: ToastGravity.BOTTOM,
                          text: 'Welcome back',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: AppIcons.icon(AppIcons.googleLogo, size: 24),
                      ),
                    ),
                    Bouncing(
                      onTap: () {
                        AppToast.of(context).show(
                          icon: Icons.person_rounded,
                          gravity: ToastGravity.BOTTOM,
                          text: 'Welcome back',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: AppIcons.icon(AppIcons.appleLogo, size: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                openLogin.call();
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: AppTextStyles.blackRegular16,
                    ),
                    TextSpan(
                      style: AppTextStyles.blackRegular16.copyWith(
                        color: AppColors.secondary,
                      ),
                      text: 'Log in.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 20,
            child: FadeInAnimation(child: widget),
          ),
        ),
      ),
    );
  }
}
