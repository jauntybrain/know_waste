import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/theme.dart';

class AnalyzedWasteSkeleton extends StatelessWidget {
  const AnalyzedWasteSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppShadows.primary],
          
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.black.withOpacity(0.08),
                  child: Container(
                    width: double.infinity,
                    color: AppColors.background,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: 200,
                child: ClipRRect(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: AppColors.white.withOpacity(0.85),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(0.1),
                          highlightColor: Colors.black.withOpacity(0.08),
                          child: Container(
                            width: 140,
                            height: 20,
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
                            width: 110,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(0.1),
                          highlightColor: Colors.black.withOpacity(0.08),
                          child: Container(
                            width: 80,
                            height: 20,
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
              ),
            ],
          ),
        ),
      );
}
