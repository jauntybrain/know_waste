import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../theme/theme.dart';
import '../providers/waste_analysis_provider.dart';

class WasteAnalysisLoadingPage extends ConsumerWidget {
  const WasteAnalysisLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wasteAnalysis = ref.watch(wasteAnalysisProvider);

    return Positioned.fill(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    width: 220,
                    height: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.95),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        key: ValueKey(wasteAnalysis.analyzedWaste),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (wasteAnalysis.analyzedWaste != null)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 38,
                                color: AppColors.white,
                              ),
                            )
                          else
                            CircularPercentIndicator(
                              radius: 40,
                              lineWidth: 6,
                              percent: wasteAnalysis.loadingProgress,
                              animation: true,
                              animateFromLastPercent: true,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: const Color(0xfff2f2f2),
                              center: Icon(
                                wasteAnalysis.processing ? Icons.document_scanner_rounded : Icons.upload_rounded,
                                size: 35,
                                color: AppColors.primary,
                              ),
                              progressColor: AppColors.primary,
                            ),
                          const SizedBox(height: 18),
                          Text(
                            wasteAnalysis.analyzedWaste != null
                                ? 'Done!'
                                : wasteAnalysis.processing
                                    ? 'Analyzing photo...'
                                    : 'Uploading photo...',
                            style: AppTextStyles.blackExtraBold16.copyWith(color: Colors.black),
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
}
