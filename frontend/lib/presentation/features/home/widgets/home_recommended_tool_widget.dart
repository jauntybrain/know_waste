import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/router/route_names.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/presentation/shared/content_box.dart';
import 'package:know_waste/presentation/theme/src/app_icons.dart';

import '../../../theme/theme.dart';

class HomeRecommendedToolWidget extends StatelessWidget {
  const HomeRecommendedToolWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: () => GoRouter.of(context).pushNamed(RouteNames.analyze),
      child: ContentBox(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AppIcons.icon(AppIcons.wasteScanner, size: 28),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended',
                  style: AppTextStyles.blackBlack22.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Waste Scanner',
                  style: AppTextStyles.blackBlack22.copyWith(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_rounded,
              size: 30,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
