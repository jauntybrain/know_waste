import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:know_waste/models/analyzed_waste/analyzed_waste.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/theme.dart';

class AnalyzedWasteWidget extends StatelessWidget {
  const AnalyzedWasteWidget({
    Key? key,
    required this.analyzedWaste,
    this.onTap,
  }) : super(key: key);

  final AnalyzedWaste analyzedWaste;
  final Function(AnalyzedWaste)? onTap;

  @override
  Widget build(BuildContext context) => Bouncing(
        onTap: () => onTap?.call(analyzedWaste),
        child: Container(
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
                  child: CachedNetworkImage(
                    imageUrl: analyzedWaste.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.08),
                      child: Container(
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: 200,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        color: AppColors.white.withOpacity(0.85),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMM d, y').format(analyzedWaste.date!),
                              style: AppTextStyles.blackBlack22.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.secondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              analyzedWaste.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.blackBlack22.copyWith(fontSize: 17.5, height: 1.2),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: analyzedWaste.recyclable!
                                    ? AppColors.primary.withOpacity(0.2)
                                    : const Color(0xffB14305).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                analyzedWaste.recyclable! ? 'Recyclable' : 'Non-Recyclable',
                                style: AppTextStyles.primaryBold14.copyWith(
                                    color: analyzedWaste.recyclable! ? AppColors.secondary : const Color(0xffB14305)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
