import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/features/community/widgets/article_search/article_search_skeleton.dart';
import 'package:know_waste/presentation/theme/theme.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../shared/app_icon_button.dart';
import '../../../shared/app_search_widget.dart';
import '../providers/search_provider.dart';
import '../widgets/article_search/article_search_widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider);

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
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text('Results', style: AppTextStyles.blackExtraBold18),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: searchState.when(
                      data: (articles) => articles != null
                          ? AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: articles.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemBuilder: (context, index) {
                                  return ArticleSearchWidget(article: articles[index]);
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 12),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('Start typing...'),
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
                    Expanded(
                      child: Hero(
                        tag: 'search_bar',
                        child: AppSearchWidget(
                          autofocus: true,
                          onSearch: ref.read(searchProvider.notifier).searchArticles,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Hero(
                      tag: 'search_close',
                      child: AppIconButton(
                        onTap: () => GoRouter.of(context).pop(),
                        size: 45,
                        iconSize: 22,
                        fillColor: AppColors.primary.withOpacity(0.1),
                        icon: Icons.close,
                      ),
                    ),
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
