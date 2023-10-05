// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';
import 'package:uni_links/uni_links.dart';

import '../../../../providers/repositories_providers.dart';
import '../../../shared/app_loading_dialog.dart';
import '../../../shared/app_toast.dart';
import '../../../theme/theme.dart';
import '../../community/pages/sections/community_challenges_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_recommended_tool_widget.dart';
import 'recycling_tools_section.dart';
import 'stats_section.dart';

final homeAppBarStateProvider = StateProvider.autoDispose<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final double appBarThreshold = 150.0;

  ScrollController scrollController = ScrollController();
  bool get showAppBar => ref.watch(homeAppBarStateProvider);

  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    try {
      handleLink(await getInitialUri());
      _sub = uriLinkStream.listen(handleLink, onError: (err) {});
    } on PlatformException {}
  }

  // TODO: Make this logic prettier
  void handleLink(Uri? uri) async {
    if (uri == null) {
      return;
    }

    try {
      AppDialog.of(context).loading();
      final path = uri.pathSegments.first;

      switch (path) {
        case 'article':
          final articleID = uri.queryParameters['id'];

          if (articleID != null) {
            final article = await ref.read(articlesRepositoryProvider).getArticle(articleID);

            if (article != null) {
              context.pushArticle(article);
            }
          }
          break;
        case 'guide':
          final guideID = uri.queryParameters['id'];

          if (guideID != null) {
            final guide = await ref.read(guidesRepositoryProvider).getGuide(guideID);

            if (guide != null) {
              context.pushGuide(guide);
            }
          }
          break;
        case 'challenge':
          final challengeID = uri.queryParameters['id'];

          if (challengeID != null) {
            final challenge = await ref.read(challengesRepositoryProvider).getChallenge(challengeID);

            if (challenge != null) {
              context.pushChallenge(challenge);
            }
          }
          break;
        default:
          break;
      }
    } catch (e) {
      AppToast.of(context).show(text: 'Invalid link', isError: true);
    } finally {
      AppDialog.dispose();
    }
  }

  @override
  void initState() {
    initUniLinks();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    scrollController.removeListener(_scrollListener());
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    final offset = scrollController.position.pixels;

    if (offset > appBarThreshold && !showAppBar) {
      ref.read(homeAppBarStateProvider.notifier).state = true;
    } else if (offset < appBarThreshold && showAppBar) {
      ref.read(homeAppBarStateProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: showAppBar ? Brightness.dark : Brightness.light,
          statusBarBrightness: showAppBar ? Brightness.light : Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              const HomeAppBar(),
              SliverSafeArea(
                top: false,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 200),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: HomeRecommendedToolWidget(),
                        ),
                        const SizedBox(height: 25),
                        const StatsSection(),
                        const SizedBox(height: 30),
                        const CommunityChallengesSection(),
                        const SizedBox(height: 15),
                        const RecyclingToolsSection(),
                        const SizedBox(height: 30),
                      ],
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(child: widget),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 200),
            top: showAppBar ? 0 : -115,
            curve: Curves.ease,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [AppShadows.small],
                border: const Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xFFf2f2f2),
                  ),
                ),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: MediaQuery.of(context).padding.top + 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcons.icon(AppIcons.logoHorizontal, color: AppColors.secondary, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
