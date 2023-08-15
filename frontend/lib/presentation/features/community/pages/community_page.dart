import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/features/community/pages/sections/community_guide_section.dart';
import 'package:know_waste/presentation/features/community/providers/articles_provider.dart';
import 'package:know_waste/presentation/features/community/providers/featured_article_provider.dart';
import 'package:know_waste/presentation/features/community/providers/guides_provider.dart';

import '../../../router/route_names.dart';
import '../../../shared/app_icon_button.dart';
import '../../../theme/theme.dart';
import 'sections/community_articles_section.dart';
import 'sections/community_challenges_section.dart';
import 'sections/community_featured_section.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends ConsumerState<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Page content
          RefreshIndicator.adaptive(
            edgeOffset: MediaQuery.of(context).viewPadding.top + 60,
            onRefresh: () async {
              ref
                ..invalidate(articlesProvider)
                ..invalidate(featuredArticleProvider)
                ..invalidate(guidesProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 80),
                  ...AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 200),
                    delay: const Duration(milliseconds: 80),
                    children: [
                      const CommunityFeaturedSection(),
                      const SizedBox(height: 30),
                      const CommunityGuidesSection(),
                      const SizedBox(height: 10),
                      const CommunityChallengesSection(),
                      const SizedBox(height: 20),
                      const CommunityArticlesSection(),
                    ],
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 30,
                      child: FadeInAnimation(child: widget),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 120),
                ],
              ),
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
                      Hero(
                        tag: 'search_bar',
                        child: AppIconButton(
                          onTap: () {
                            GoRouter.of(context).pushNamed(RouteNames.search);
                          },
                          size: 45,
                          iconSize: 22,
                          fillColor: AppColors.primary.withOpacity(0.1),
                          icon: Icons.search_rounded,
                        ),
                      ),
                      Text(
                        'Community',
                        style: AppTextStyles.blackBlack22.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Hero(
                        tag: 'search_close',
                        child: AppIconButton(
                          onTap: () => GoRouter.of(context).pushNamed(RouteNames.bookmarks),
                          size: 45,
                          iconSize: 22,
                          fillColor: AppColors.primary.withOpacity(0.1),
                          icon: Icons.bookmarks_rounded,
                        ),
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
