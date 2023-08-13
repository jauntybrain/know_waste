import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/src/app_colors.dart';
import '../../../../theme/src/app_shadows.dart';
import '../../../../theme/src/app_text_styles.dart';

class CommunityChallengesSection extends ConsumerWidget {
  const CommunityChallengesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final challengesState = ref.watch(featuredArticleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Try a Challenge',
            style: AppTextStyles.blackBlack22.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Wrap(
                children: [
                  Container(
                    width: 220,
                    padding: const EdgeInsets.all(8),
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
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: ColoredBox(
                                    color: AppColors.primary.withOpacity(0.2),
                                  ),
                                ),
                                Positioned(child: SvgPicture.asset('assets/images/jade-advice.svg')),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recycling',
                                style: AppTextStyles.blackBlack22.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Plastic Master',
                                style: AppTextStyles.blackBlack22.copyWith(fontSize: 18),
                              ),
                              Text(
                                'Master the skill of recycling plastic objects',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.grayMedium14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Wrap(
                children: [
                  Container(
                    width: 220,
                    padding: const EdgeInsets.all(8),
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
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: ColoredBox(
                                    color: const Color(0xffFEAD62).withOpacity(0.2),
                                  ),
                                ),
                                Positioned(child: SvgPicture.asset('assets/images/jade-advice.svg')),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recycling',
                                style: AppTextStyles.blackBlack22.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Paper Master',
                                style: AppTextStyles.blackBlack22.copyWith(fontSize: 18),
                              ),
                              Text(
                                'Master the skill of recycling plastic objects',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.grayMedium14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
