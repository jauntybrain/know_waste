import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/content_box.dart';
import '../../../theme/theme.dart';
import '../providers/challenge_stats_provider.dart';

class ChallengeStatsSection extends ConsumerWidget {
  const ChallengeStatsSection({required this.challengeID, this.percent, super.key});

  final String challengeID;
  final double? percent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(challengeStatsProvider(challengeID));
    final isLoading = statsState is AsyncLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenge Stats',
          style: AppTextStyles.blackExtraBold20,
        ),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: percent != null
              ? ContentBox(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your progress',
                        style: AppTextStyles.blackBold16,
                      ),
                      const SizedBox(height: 8),
                      LinearPercentIndicator(
                        lineHeight: 8,
                        padding: EdgeInsets.zero,
                        percent: percent!,
                        barRadius: const Radius.circular(3),
                        backgroundColor: AppColors.background,
                        progressColor: AppColors.secondary,
                        animation: true,
                        restartAnimation: false,
                        animateFromLastPercent: true,
                        animationDuration: 200,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        if (percent != null) const SizedBox(height: 10),
        ContentBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Recycled',
                      style: AppTextStyles.blackBold16,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.black.withOpacity(0.08),
                              child: Container(
                                height: 22,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                          : Text(
                              ref.watch(challengeStatsProvider(challengeID).notifier).totalRecycled.toString(),
                              style: AppTextStyles.blackBold16.copyWith(color: AppColors.secondary),
                            ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 4,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Participants',
                      style: AppTextStyles.blackBold16,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLoading
                          ? Shimmer.fromColors(
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
                            )
                          : Text(
                              ref.watch(challengeStatsProvider(challengeID).notifier).usersJoined.toString(),
                              style: AppTextStyles.blackBold16.copyWith(color: AppColors.secondary),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
