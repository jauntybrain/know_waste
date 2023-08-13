import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_shadows.dart';

class ArticleWidgetSkeleton extends StatelessWidget {
  const ArticleWidgetSkeleton({Key? key})
      : isLarge = false,
        super(key: key);

  const ArticleWidgetSkeleton.large({Key? key})
      : isLarge = true,
        super(key: key);

  final bool isLarge;

  Widget _buildRegularSkeleton() => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xfff2f2f2)),
          boxShadow: [AppShadows.primary],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.black.withOpacity(0.1),
                highlightColor: Colors.black.withOpacity(0.08),
                child: Container(height: 100, color: AppColors.white),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 5),
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
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.08),
                      child: Container(
                        height: 25,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildLargeSkeleton() => Container(
        decoration: BoxDecoration(boxShadow: [AppShadows.primary]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            color: AppColors.white,
            height: AppConstants.featuredArticleHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Row(
                children: [
                  Expanded(
                    child: ColoredBox(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
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
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.black.withOpacity(0.08),
                              child: Container(
                                height: 24,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.black.withOpacity(0.08),
                              child: Container(
                                height: 25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.black.withOpacity(0.08),
                              child: Container(
                                height: 25,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.black.withOpacity(0.08),
                              child: Container(
                                height: 42,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.08),
                      child: Container(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => isLarge ? _buildLargeSkeleton() : _buildRegularSkeleton();
}
