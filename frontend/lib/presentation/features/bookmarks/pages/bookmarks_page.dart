import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:know_waste/presentation/features/community/providers/articles_provider.dart';
import 'package:know_waste/presentation/features/community/widgets/article_search/article_search_skeleton.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../shared/app_icon_button.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_shadows.dart';
import '../../../theme/src/app_text_styles.dart';
import '../../community/widgets/article_search/article_search_widget.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(articlesProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Page content
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 60),
                  searchState.when(
                    data: (articles) => ListView.separated(
                      shrinkWrap: true,
                      itemCount: articles.length + 1,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(height: 8);
                        }
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          delay: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                            verticalOffset: 30,
                            child: FadeInAnimation(
                              child: ArticleSearchWidget(article: articles[index - 1]),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                    loading: () => ListView.separated(
                      shrinkWrap: true,
                      itemCount: 7,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(height: 8);
                        }
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          delay: const Duration(milliseconds: 300),
                          child: const SlideAnimation(
                            verticalOffset: 30,
                            child: FadeInAnimation(child: ArticleSearchSkeleton()),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                    error: (e, tr) => Text(e is ApiError ? (e).message : 'Error occurred'),
                  ),
                ],
              ),
            ),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(1),
                  boxShadow: [AppShadows.small],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 12,
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      onTap: () {},
                      size: 45,
                      iconSize: 22,
                      fillColor: AppColors.primary.withOpacity(0.1),
                      icon: Icons.chevron_left_rounded,
                    ),
                    Text(
                      'Bookmarks',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
