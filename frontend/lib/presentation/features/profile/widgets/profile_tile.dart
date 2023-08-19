import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/shared/app_icon_button.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/presentation/shared/content_box.dart';
import 'package:know_waste/presentation/theme/theme.dart';
import 'package:know_waste/providers/auth_provider.dart';

import '../../../../models/profile_item.dart';

class ProfileTile extends ConsumerWidget {
  const ProfileTile({
    required this.profileItem,
    Key? key,
  }) : super(key: key);

  final ProfileItem profileItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Bouncing(
      onTap: () {
        if (profileItem.routeName == 'logout') {
          ref.read(authProvider.notifier).signOut();
        } else {
          GoRouter.of(context).goNamed(profileItem.routeName);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: ContentBox(
          padding: const EdgeInsets.all(12),
          borderRadius: 12,
          child: Row(
            children: [
              AppIconButton(
                onTap: () {},
                size: 40,
                iconSize: 19,
                radius: 10,
                fillColor: AppColors.primary.withOpacity(0.1),
                icon: profileItem.icon,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileItem.title,
                      style: AppTextStyles.blackExtraBold16,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      profileItem.subtitle,
                      style: AppTextStyles.grayMedium14.copyWith(
                        color: const Color(0xffADADAD),
                      ),
                    ),
                  ],
                ),
              ),
              if (profileItem.hasChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.secondary,
                  size: 24,
                ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
