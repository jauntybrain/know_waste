import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_icon_button.dart';
import '../../../shared/app_toast.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';

// TODO - Add more settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Page content
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 75),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [AppShadows.small],
                      border: Border.all(color: const Color(0xfff2f2f2)),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                              ),
                              child: AppIcons.icon(
                                AppIcons.notifications,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'Allow notifications',
                              style: AppTextStyles.blackBold16,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Switch.adaptive(
                          value: true,
                          activeColor: AppColors.secondary,
                          onChanged: (bool value) => AppToast.of(context).show(
                            text: 'Coming soon!',
                            icon: Icons.hourglass_top_rounded,
                            gravity: ToastGravity.BOTTOM,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [AppShadows.small],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 12,
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      onTap: () => GoRouter.of(context).pop(),
                      size: 45,
                      iconSize: 22,
                      fillColor: AppColors.primary.withOpacity(0.1),
                      icon: Icons.chevron_left_rounded,
                    ),
                    Text(
                      'Settings',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
