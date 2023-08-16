import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ChallengeStatsSection extends StatelessWidget {
  const ChallengeStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenge Stats',
          style: AppTextStyles.blackExtraBold20,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [AppShadows.small],
            border: Border.all(color: const Color(0xfff2f2f2)),
          ),
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
                    Text(
                      '0',
                      style: AppTextStyles.blackBold16.copyWith(color: AppColors.secondary),
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
                    Text(
                      '0',
                      style: AppTextStyles.blackBold16.copyWith(color: AppColors.secondary),
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
