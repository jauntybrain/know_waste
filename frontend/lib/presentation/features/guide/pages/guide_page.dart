import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/models/guide/guide.dart';
import 'package:know_waste/presentation/shared/app_markdown.dart';
import 'package:know_waste/utils/extensions.dart';

import '../../../shared/app_icon_button.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_text_styles.dart';

class GuidePage extends ConsumerWidget {
  const GuidePage({required this.guide, super.key});

  final Guide guide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Page content
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 60),
                ...AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 200),
                  children: [
                    SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: guide.imageUrl,
                        width: double.infinity,
                        imageBuilder: (context, image) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Image(
                                image: image,
                                fit: BoxFit.cover,
                                color: guide.color.hexToColor().withOpacity(0.8),
                                colorBlendMode: BlendMode.color,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 12,
                              child: Text(
                                '@Unsplash',
                                style: AppTextStyles.whiteSemiBold12,
                              ),
                            ),
                            Positioned.fill(
                              child: ColoredBox(color: Colors.black.withOpacity(0.4)),
                            ),
                            Positioned(
                              bottom: 25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.network(
                                    guide.iconUrl,
                                    height: 60,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Recycling Guide: ${guide.material}',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.whiteExtraBold26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: AppMarkdown(text: guide.content, lineHeight: 1.5),
                    ),
                  ],
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 55,
                    child: FadeInAnimation(child: widget),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 100),
              ],
            ),
          ),
          // Top Navigation
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 12,
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  color: AppColors.white.withOpacity(0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIconButton(
                        onTap: () => GoRouter.of(context).pop(),
                        size: 45,
                        iconSize: 22,
                        fillColor: AppColors.primary.withOpacity(0.1),
                        icon: Icons.chevron_left_rounded,
                      ),
                      Text(
                        'Recycling Guide',
                        style: AppTextStyles.blackExtraBold18.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 45),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
