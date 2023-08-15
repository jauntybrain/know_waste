import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/api_error/api_error.dart';
import 'package:know_waste/presentation/features/community/providers/featured_article_provider.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';
import 'package:know_waste/utils/constants.dart';

import '../../../../theme/src/app_colors.dart';
import '../../../../theme/src/app_shadows.dart';
import '../../../../theme/src/app_text_styles.dart';
import '../../widgets/article/article_widget.dart';
import '../../widgets/article/article_widget_skeleton.dart';

class CommunityFeaturedSection extends ConsumerWidget {
  const CommunityFeaturedSection({super.key});

  Widget articleContainer({required String text}) => Container(
        height: AppConstants.featuredArticleHeight,
        decoration: BoxDecoration(
          boxShadow: [AppShadows.primary],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(text),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(featuredArticleProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: AppTextStyles.blackBlack22,
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Container(
              key: ValueKey(articleState),
              child: articleState.when(
                data: (article) => article != null
                    ? ArticleWidget.large(article: article, onTap: context.pushArticle)
                    : articleContainer(text: 'Coming soon!'),
                loading: () => const ArticleWidgetSkeleton.large(),
                error: (e, tr) => articleContainer(text: e is ApiError ? (e).message : 'Error occurred'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
