import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_icon_button.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';

// TODO - Make dynamic
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      AppIcons.icon(AppIcons.notifications, size: 70),
                      const SizedBox(height: 20),
                      Text('No notifications yet', style: AppTextStyles.blackExtraBold16),
                    ],
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
                      'Notifications',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 19,
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
