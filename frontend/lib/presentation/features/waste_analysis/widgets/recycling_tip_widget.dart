import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_text_styles.dart';

class RecyclingTipWidget extends StatelessWidget {
  const RecyclingTipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      width: MediaQuery.of(context).size.width - 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Wrap(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.95),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/jade-tips.svg',
                            height: 40,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recycling 101'.toUpperCase(),
                                style: AppTextStyles.blackBlack22.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Did you know?',
                                style: AppTextStyles.blackBlack22.copyWith(height: 1.1, fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Research shows convenience and commitment are required for maximum recycling. For instance, do you recycle in several rooms of your home? If you only recycle in the kitchen, recyclables in your home office or bathroom get thrown away.',
                        style: AppTextStyles.grayMedium16,
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
}
