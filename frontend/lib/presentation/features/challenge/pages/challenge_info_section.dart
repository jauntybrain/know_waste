import 'package:flutter/material.dart';
import 'package:know_waste/presentation/theme/theme.dart';

class ChallengeInfoSection extends StatelessWidget {
  const ChallengeInfoSection({required this.criteria, super.key});

  final String criteria;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [AppShadows.small],
              border: Border.all(color: const Color(0xfff2f2f2)),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                      ),
                      child: const Icon(
                        Icons.access_time_filled_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Unlimited',
                      style: AppTextStyles.blackExtraBold16,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [AppShadows.small],
              border: Border.all(color: const Color(0xfff2f2f2)),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                      ),
                      child: const Icon(
                        Icons.flag_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      criteria,
                      style: AppTextStyles.blackExtraBold16,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
