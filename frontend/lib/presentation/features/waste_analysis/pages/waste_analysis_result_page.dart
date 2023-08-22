import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../shared/app_markdown.dart';
import '../../../theme/theme.dart';
import '../providers/waste_analysis_provider.dart';

class WasteAnalysisResultPage extends ConsumerWidget {
  const WasteAnalysisResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wasteAnalysis = ref.watch(wasteAnalysisProvider);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 400),
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: MediaQuery.of(context).viewPadding.bottom + 140,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 80,
            ),
            ...AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 280,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(
                            wasteAnalysis.pickedImage!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.secondary.withOpacity(0.2),
                                  AppColors.secondary.withOpacity(0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.85),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width - 60,
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    if (wasteAnalysis.analyzedWaste!.recyclable ?? false)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.recycling_rounded,
                                              color: AppColors.secondary,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Recyclable',
                                              style: AppTextStyles.primaryExtraBold14
                                                  .copyWith(color: AppColors.secondary, height: 1.4),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffB14305).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.recycling_rounded,
                                              color: Color(0xffB14305),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Non-Recyclable',
                                              style: AppTextStyles.primaryExtraBold14
                                                  .copyWith(color: const Color(0xffB14305), height: 1.4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff0C5BD2).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.category_rounded,
                                            color: Color(0xff0C5BD2),
                                            size: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            wasteAnalysis.analyzedWaste!.material ?? 'Unknown material',
                                            style: AppTextStyles.primaryExtraBold14
                                                .copyWith(color: const Color(0xff0C5BD2), height: 1.4),
                                          ),
                                        ],
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
                const SizedBox(height: 20),
                Text(
                  'AI Recycling advice for...',
                  style: AppTextStyles.blackBlack22.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
                Text(
                  wasteAnalysis.analyzedWaste!.name ?? 'Loading...',
                  style: AppTextStyles.blackBlack22.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 5),
                AppMarkdown(text: wasteAnalysis.analyzedWaste?.advice ?? 'Loading...'),
                const SizedBox(height: 25),
                Text(
                  'AI-Powered',
                  style: AppTextStyles.blackBlack22.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
                Text('Tips & Tricks', style: AppTextStyles.blackBlack22),
                const SizedBox(height: 4),
                AppMarkdown(text: wasteAnalysis.analyzedWaste?.tips ?? 'Loading...'),
              ],
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 30,
                child: FadeInAnimation(child: widget),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
