import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/providers/auth_provider.dart';

import '../../../shared/app_toast.dart';
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
                onTap: onRegister,
                height: 50,
                width: 215,
                fillColor: AppColors.secondary.withOpacity(0.1),
                textColor: AppColors.secondary,
                hasShadow: false,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Continue with email'),
                  ],
                ),
              ),
              Container(height: 20, width: 1, color: Colors.black.withOpacity(0.1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bouncing(
                    onTap: () {
                      ref.read(authProvider.notifier).signInWithGoogle();
                      AppToast.of(context).show(
                        icon: Icons.person_rounded,
                        gravity: ToastGravity.BOTTOM,
                        text: 'Welcome back!',
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
                      ref.read(authProvider.notifier).signInWithApple();
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
    );
  }
}
