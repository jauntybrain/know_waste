import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../models/analyzed_waste/analyzed_waste.dart';
import '../../../shared/app_markdown.dart';
import '../../../theme/theme.dart';
import '../../waste_analysis/widgets/waste_analysis_top_nav.dart';

class AnalyzedWasteDetailPage extends ConsumerWidget {
  const AnalyzedWasteDetailPage({required this.analyzedWaste, super.key});

  final AnalyzedWaste analyzedWaste;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                child: CachedNetworkImage(
                                  imageUrl: analyzedWaste.imageUrl!,
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
                                          if (analyzedWaste.recyclable ?? false)
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
                                                  analyzedWaste.material ?? 'Unknown material',
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
                        analyzedWaste.name!,
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 5),
                      AppMarkdown(text: analyzedWaste.advice!),
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
                      AppMarkdown(text: analyzedWaste.tips!),
                    ],
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 30,
                      child: FadeInAnimation(child: widget),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: const WasteAnalysisTopNav(
              title: 'Analyzed Waste',
              blurred: true,
              showHelp: false,
            ),
          ),
        ],
      ),
    );
  }
}
