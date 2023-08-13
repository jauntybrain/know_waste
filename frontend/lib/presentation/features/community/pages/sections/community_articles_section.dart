import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/api_error/api_error.dart';
import 'package:know_waste/presentation/features/community/providers/articles_provider.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';

import '../../../../theme/src/app_colors.dart';
import '../../../../theme/src/app_shadows.dart';
import '../../../../theme/src/app_text_styles.dart';
import '../../widgets/article/article_widget.dart';
import '../../widgets/article/article_widget_skeleton.dart';

class CommunityArticlesSection extends ConsumerWidget {
  const CommunityArticlesSection({super.key});

  Widget articlePlaceholder({Widget? child}) => Container(
        decoration: BoxDecoration(
          boxShadow: [AppShadows.primary],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesState = ref.watch(articlesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Read Articles',
            style: AppTextStyles.blackBlack22.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        articlesState.when(
          data: (articles) => GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 310,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) => ArticleWidget(
              article: articles[index],
              onTap: context.pushArticle,
            ),
          ),
          error: (e, tr) => Center(
            child: e is ApiError ? Text((e).message) : const Text('Error occurred'),
          ),
          loading: () => GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 270,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: 4,
            itemBuilder: (context, index) => const ArticleWidgetSkeleton(),
          ),
        ),
      ],
    );
  }
}


// Container(
                //   decoration: BoxDecoration(
                //     boxShadow: [AppShadows.primary],
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(16),
                //     child: Container(
                //       height: 240,
                //       color: AppColors.white,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: Container(
                //               decoration: const BoxDecoration(
                //                 color: AppColors.white,
                //                 // boxShadow: [AppShadows.primary],
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.all(20),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'Article'.toUpperCase(),
                //                       style: AppTextStyles.blackBlack22.copyWith(
                //                         color: AppColors.secondary,
                //                         fontSize: 12,
                //                       ),
                //                     ),
                //                     Text(
                //                       'Can Recycling Really Help Combat Climate Change?',
                //                       style: AppTextStyles.blackBlack22.copyWith(fontSize: 19.5),
                //                     ),
                //                     const Spacer(),
                //                     AppButton.primary(
                //                       fillColor: AppColors.secondary,
                //                       textColor: AppColors.white,
                //                       height: 45,
                //                       width: 120,
                //                       borderRadius: 16,
                //                       onTap: () {},
                //                       hasShadow: false,
                //                       child: const Text('Read Now'),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Expanded(
                //             child: Image.network(
                //               'https://images.unsplash.com/photo-1690902303020-a980f1eda16b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1015&q=80',
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),