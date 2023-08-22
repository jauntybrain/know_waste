import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';

class GuideWidgetSkeleton extends StatelessWidget {
  const GuideWidgetSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xfff2f2f2)),
          boxShadow: [AppShadows.primary],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.black.withOpacity(0.08),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.black.withOpacity(0.08),
                  child: Container(
                    height: 20,
                    width: 90,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.black.withOpacity(0.08),
                  child: Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
      );
}
