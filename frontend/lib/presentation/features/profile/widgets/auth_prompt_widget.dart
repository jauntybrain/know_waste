import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/providers/auth_provider.dart';

import '../../../shared/app_toast.dart';
import '../../../shared/content_box.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';

class AuthPromptWidget extends ConsumerWidget {
  const AuthPromptWidget({
    this.onRegister,
    this.onLogin,
    super.key,
  });

  final void Function()? onRegister, onLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smallScreen = MediaQuery.of(context).size.width < 390;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ContentBox(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        borderRadius: 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '♻️ Join KnowWaste',
              textAlign: TextAlign.start,
              style: AppTextStyles.blackBlack22.copyWith(fontSize: 21),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 350,
              child: Text(
                'Unlock full potential with a free account.',
                textAlign: TextAlign.start,
                style: AppTextStyles.grayMedium16.copyWith(
                  color: const Color(0xffAEAEAE),
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flex(
              direction: smallScreen ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton.primary(
                  onTap: onRegister,
                  height: 50,
                  width: smallScreen ? double.infinity : 215,
                  fillColor: AppColors.secondary.withOpacity(0.1),
                  textColor: AppColors.secondary,
                  hasShadow: false,
                  child: const Text('Continue with email'),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.black.withOpacity(smallScreen ? 0 : 0.1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bouncing(
                      onTap: () {
                        ref.read(authProvider.notifier).signInWithGoogle(
                              onSuccess: () => AppToast.of(context).show(
                                icon: Icons.person_rounded,
                                text: 'Welcome to KnowWaste! 🎉',
                              ),
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
                        ref.read(authProvider.notifier).signInWithApple(
                              onSuccess: () => AppToast.of(context).show(
                                icon: Icons.person_rounded,
                                text: 'Welcome to KnowWaste! 🎉',
                              ),
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
            // TODO: Introduce email login in the future
            // const SizedBox(height: 22),
            // Bouncing(
            //   onTap: onLogin,
            //   child: RichText(
            //     text: TextSpan(
            //       children: [
            //         TextSpan(
            //           text: 'Already have an account? ',
            //           style: AppTextStyles.blackRegular16,
            //         ),
            //         TextSpan(
            //           style: AppTextStyles.blackRegular16.copyWith(
            //             color: AppColors.secondary,
            //           ),
            //           text: 'Log in.',
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
