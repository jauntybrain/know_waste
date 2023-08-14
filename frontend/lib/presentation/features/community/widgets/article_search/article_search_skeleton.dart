import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';

class ArticleSearchSkeleton extends StatelessWidget {
  const ArticleSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xfff2f2f2)),
        boxShadow: [AppShadows.primary],
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.black.withOpacity(0.08),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 140,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(0.1),
                    highlightColor: Colors.black.withOpacity(0.08),
                    child: Container(
                      height: 20,
                      width: 200,
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
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(0.1),
                    highlightColor: Colors.black.withOpacity(0.08),
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
