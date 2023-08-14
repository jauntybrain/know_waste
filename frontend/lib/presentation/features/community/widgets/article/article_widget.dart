import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:know_waste/models/article/article.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/constants.dart';
import '../../../../theme/src/app_buttons.dart';
import '../../../../theme/src/app_colors.dart';
import '../../../../theme/src/app_shadows.dart';
import '../../../../theme/src/app_text_styles.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    Key? key,
    required this.article,
    this.onTap,
  })  : isLarge = false,
        super(key: key);

  const ArticleWidget.large({
    Key? key,
    required this.article,
    this.onTap,
  })  : isLarge = true,
        super(key: key);

  final Article article;
  final Function(Article)? onTap;
  final bool isLarge;

  Widget _buildRegularArticle() => Container(
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      fit: BoxFit.cover,
                      height: 140,
                      progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(0.1),
                        highlightColor: Colors.black.withOpacity(0.08),
                        child: Container(
                          width: double.infinity,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            AppColors.primary.withOpacity(0.1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  // TODO: add bookmark button
                  // Positioned(
                  //   top: 10,
                  //   right: 10,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(12),
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  //       child: AppIconButton(
                  //         onTap: () {},
                  //         size: 40,
                  //         iconSize: 20,
                  //         radius: 12,
                  //         fillColor: AppColors.white.withOpacity(0.8),
                  //         icon: Icons.bookmark_outline_rounded,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM d, y').format(article.date),
                      style: AppTextStyles.blackBlack22.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      article.title,
                      style: AppTextStyles.blackBlack22.copyWith(fontSize: 17.5, height: 1.2),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        article.tag,
                        style: AppTextStyles.primaryBold14.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildLargeArticle(BuildContext context) => Container(
        decoration: BoxDecoration(boxShadow: [AppShadows.primary]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            color: AppColors.white,
            height: AppConstants.featuredArticleHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.08),
                      child: Container(
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  height: AppConstants.featuredArticleHeight,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.92),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Article'.toUpperCase(),
                                style: AppTextStyles.blackBlack22.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                article.title.split(' ').map((word) => word.capitalize()).join(' '),
                                style: AppTextStyles.blackBlack22.copyWith(fontSize: 19),
                              ),
                              const Spacer(),
                              AppButton.primary(
                                fillColor: AppColors.secondary,
                                textColor: AppColors.white,
                                height: 42,
                                width: 120,
                                borderRadius: 40,
                                onTap: () => onTap?.call(article),
                                hasShadow: true,
                                child: const Text('Read Now'),
                              ),
                            ],
                          ),
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

  @override
  Widget build(BuildContext context) => Bouncing(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap?.call(article);
        },
        child: isLarge ? _buildLargeArticle(context) : _buildRegularArticle(),
      );
}
