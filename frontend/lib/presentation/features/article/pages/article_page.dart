import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:know_waste/presentation/shared/app_markdown.dart';

import '../../../../models/article/article.dart';
import '../../../shared/app_icon_button.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_text_styles.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 90),
                ...AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 200),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        article.tag.toUpperCase(),
                        style: AppTextStyles.primaryExtraBold14
                            .copyWith(color: AppColors.secondary, height: 1.42, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 280,
                      child: Text(
                        article.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 24, height: 1.2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${DateFormat('MMMM d y').format(article.date)}  •  KnowWaste',
                      style: AppTextStyles.graySemiBold12,
                    ),
                    const SizedBox(height: 35),
                    CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      height: 280,
                      width: double.infinity,
                      imageBuilder: (context, image) => Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              image: image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 12,
                            child: Text(
                              '@Unsplash',
                              style: AppTextStyles.whiteSemiBold12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: AppMarkdown(text: article.content, lineHeight: 1.5),
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
                        'Article',
                        style: AppTextStyles.blackExtraBold18.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      AppIconButton(
                        onTap: () {},
                        size: 45,
                        iconSize: 22,
                        fillColor: AppColors.primary.withOpacity(0.1),
                        icon: Icons.bookmark_outline_rounded,
                      ),
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
