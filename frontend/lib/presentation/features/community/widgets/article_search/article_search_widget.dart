import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/article/article.dart';
import '../../../../shared/bouncing.dart';
import '../../../../theme/theme.dart';

class ArticleSearchWidget extends StatelessWidget {
  const ArticleSearchWidget({
    Key? key,
    required this.article,
    this.onTap,
  }) : super(key: key);

  final Article article;
  final Function(Article)? onTap;

  @override
  Widget build(BuildContext context) => Bouncing(
        onTap: () => onTap?.call(article),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xfff2f2f2)),
            boxShadow: [AppShadows.small],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    fit: BoxFit.cover,
                    width: 120,
                    height: double.infinity,
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
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
              const SizedBox(width: 12),
            ],
          ),
        ),
      );
}
