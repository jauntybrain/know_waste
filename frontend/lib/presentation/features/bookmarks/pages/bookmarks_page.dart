import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/features/community/widgets/article_search/article_search_skeleton.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';
import 'package:know_waste/presentation/theme/src/app_icons.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../../providers/user_provider.dart';
import '../../../shared/app_icon_button.dart';
import '../../../shared/app_toast.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_shadows.dart';
import '../../../theme/src/app_text_styles.dart';
import '../../community/providers/bookmarks_provider.dart';
import '../../community/widgets/article_search/article_search_widget.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarksProvider);
    final isEmpty = bookmarksState.value?.isEmpty ?? false;

    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Page content
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: isEmpty ? MediaQuery.of(context).size.height : null,
                ),
                child: Column(
                  mainAxisAlignment: isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!isEmpty) SizedBox(height: MediaQuery.of(context).viewPadding.top + 60),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: bookmarksState.when(
                        data: (articles) => articles.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: articles.length + 1,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return const SizedBox(height: 8);
                                  }
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: ArticleSearchWidget(
                                      article: articles[index - 1],
                                      onTap: context.pushArticle,
                                      onBookmark: (article) {
                                        ref.read(userProvider.notifier).removeBookmark(article.uid, (success) {
                                          AppToast.of(context).show(
                                            gravity: ToastGravity.BOTTOM,
                                            text: 'Removed from bookmarks!',
                                          );
                                        });
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 12),
                              )
                            : Center(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      AppIcons.icon(AppIcons.bookmarks, size: 70),
                                      const SizedBox(height: 20),
                                      Text('No bookmarks yet', style: AppTextStyles.blackExtraBold16),
                                    ],
                                  ),
                                ),
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
            ),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
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
                      onTap: () => GoRouter.of(context).pop(),
                      size: 45,
                      iconSize: 22,
                      fillColor: AppColors.primary.withOpacity(0.1),
                      icon: Icons.chevron_left_rounded,
                    ),
                    Text(
                      'Bookmarks',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 19,
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
