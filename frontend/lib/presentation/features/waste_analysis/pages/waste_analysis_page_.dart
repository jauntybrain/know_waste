import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:know_waste/presentation/theme/theme.dart';

import '../../../shared/app_markdown.dart';
import '../providers/waste_analysis_provider.dart';

class WasteAnalysisPage1 extends ConsumerStatefulWidget {
  const WasteAnalysisPage1({Key? key}) : super(key: key);

  @override
  WasteAnalysisPage1State createState() => WasteAnalysisPage1State();
}

class WasteAnalysisPage1State extends ConsumerState<WasteAnalysisPage1> {
  @override
  Widget build(BuildContext context) {
    final wasteAnalysis = ref.watch(wasteAnalysisProvider);
    final streamSnapshot = ref.watch(firestoreStreamProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1558169550-45825435a09b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', //wasteAnalysis.pickedImage!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Container(
                  color: const Color(0xffCCF7DC).withOpacity(0.8),
                  width: double.infinity,
                ),
              ),
            ),
          ),

          // if (wasteAnalysis.analyzedWaste == null)
          Positioned.fill(
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 20),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(12),
              //   boxShadow: [AppShadows.primary],
              // ),
              child: Center(
                child: streamSnapshot.when(
                  data: (value) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1558169550-45825435a09b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', //wasteAnalysis.pickedImage!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/jade-advice.svg',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'KnowWaste AI',
                                          style: AppTextStyles.blackBold14.copyWith(color: const Color(0xff00D84F)),
                                        ),
                                        Text(
                                          'Tips & Solutions',
                                          style: AppTextStyles.blackExtraBold18,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                AppMarkdown(text: wasteAnalysis.analyzedWaste?.tips?.trim() ?? 'Loading advice'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.2),
                      //         blurRadius: 20,
                      //         spreadRadius: -5,
                      //         offset: const Offset(0, 5),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      //         child: Column(
                      //           children: [
                      //             if (wasteAnalysis.analyzedWaste?.name != null)
                      //               Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.white,
                      //                       boxShadow: [AppShadows.primary],
                      //                       borderRadius: BorderRadius.circular(40),
                      //                     ),
                      //                     child: Text(wasteAnalysis.analyzedWaste!.name.toString()),
                      //                   ),
                      //                   const SizedBox(width: 10),
                      //                   Container(
                      //                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.white,
                      //                       boxShadow: [AppShadows.primary],
                      //                       borderRadius: BorderRadius.circular(40),
                      //                     ),
                      //                     child: Text(wasteAnalysis.analyzedWaste!.material.toString()),
                      //                   ),
                      //                   const SizedBox(width: 10),
                      //                   Container(
                      //                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.white,
                      //                       boxShadow: [AppShadows.primary],
                      //                       borderRadius: BorderRadius.circular(40),
                      //                     ),
                      //                     child: Text(wasteAnalysis.analyzedWaste!.recyclable!
                      //                         ? 'RECYCLABLE'
                      //                         : 'NON-RECYCLABLE'),
                      //                   ),
                      //                 ],
                      //               ),
                      //             const SizedBox(height: 20),
                      //             Column(
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       'assets/images/jade-advice.svg',
                      //                       height: 30,
                      //                       width: 30,
                      //                     ),
                      //                     const SizedBox(width: 12),
                      //                     Column(
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           'KnowWaste AI',
                      //                           style:
                      //                               AppTextStyles.blackBold14.copyWith(color: const Color(0xff00D84F)),
                      //                         ),
                      //                         Text(
                      //                           'Recycling advice',
                      //                           style: AppTextStyles.blackExtraBold18,
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 const SizedBox(height: 10),
                      //                 AppMarkdown(
                      //                   text: wasteAnalysis.analyzedWaste?.advice?.trim() ?? 'Loading advice',
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(height: 25),
                      //             Column(
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       'assets/images/jade-advice.svg',
                      //                       height: 30,
                      //                       width: 30,
                      //                     ),
                      //                     const SizedBox(width: 12),
                      //                     Column(
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           'KnowWaste AI',
                      //                           style:
                      //                               AppTextStyles.blackBold14.copyWith(color: const Color(0xff00D84F)),
                      //                         ),
                      //                         Text(
                      //                           'Tips & Solutions',
                      //                           style: AppTextStyles.blackExtraBold18,
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 const SizedBox(height: 10),
                      //                 AppMarkdown(text: wasteAnalysis.analyzedWaste?.tips?.trim() ?? 'Loading advice'),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  error: (e, st) => const Text('error'),
                  loading: () => const CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 120,
                  sigmaY: 15,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 12,
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  color: Colors.white.withOpacity(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xfff4f4f4),
                          borderRadius: BorderRadius.circular(8),
                          // boxShadow: [AppShadows.primary],
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xff007029),
                        ),
                      ),
                      Text(
                        'Waste Analysis',
                        style: AppTextStyles.blackExtraBold18.copyWith(
                          color: const Color(0xff007029),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (wasteAnalysis.analyzedWaste != null)
            Positioned(
              bottom: 10 + MediaQuery.of(context).viewPadding.bottom,
              right: 30,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [AppShadows.primary],
                    ),
                    child: const Icon(
                      Icons.recycling,
                      size: 24,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
