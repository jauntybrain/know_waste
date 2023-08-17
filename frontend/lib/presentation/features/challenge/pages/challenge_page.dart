import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/models/challenge/challenge.dart';
import 'package:know_waste/presentation/features/challenge/pages/challenge_info_section.dart';
import 'package:know_waste/presentation/features/challenge/widgets/challenge_app_bar.dart';
import 'package:know_waste/presentation/shared/app_markdown.dart';
import 'package:know_waste/presentation/theme/theme.dart';
import 'package:know_waste/utils/extensions.dart';

import '../../../shared/app_icon_button.dart';
import 'challenge_stats_section.dart';

final challengeAppBarStateProvider = StateProvider.autoDispose<bool>((ref) => false);

class ChallengePage extends ConsumerStatefulWidget {
  const ChallengePage({required this.challenge, Key? key}) : super(key: key);

  final Challenge challenge;

  @override
  ChallengePageState createState() => ChallengePageState();
}

class ChallengePageState extends ConsumerState<ChallengePage> {
  final double appBarThreshold = 150.0;

  ScrollController scrollController = ScrollController();
  bool get showAppBar => ref.watch(challengeAppBarStateProvider);

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener());
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    final offset = scrollController.position.pixels;

    if (offset > appBarThreshold && !showAppBar) {
      ref.read(challengeAppBarStateProvider.notifier).state = true;
    } else if (offset < appBarThreshold && showAppBar) {
      ref.read(challengeAppBarStateProvider.notifier).state = false;
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
        fit: StackFit.expand,
        children: [
          // Page content
          CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              ChallengeAppBar(
                background: widget.challenge.imageUrl,
                medal: widget.challenge.iconUrl,
                color: widget.challenge.color.hexToColor(),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 200),
                        children: [
                          const SizedBox(height: 1),
                          Align(
                            alignment: Alignment.topRight,
                            child: AppButton.primary(
                              borderRadius: 50,
                              height: 44,
                              width: 160,
                              onTap: () {},
                              child: const Text('Join Challenge'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.challenge.tool,
                            style: AppTextStyles.blackBlack22.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.secondary,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.challenge.title,
                            style: AppTextStyles.blackBlack22.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 10),
                          ChallengeInfoSection(criteria: widget.challenge.criteria),
                          const SizedBox(height: 15),
                          AppMarkdown(text: widget.challenge.content, lineHeight: 1.5),
                          const SizedBox(height: 20),
                          ChallengeStatsSection(challengeID: widget.challenge.uid),
                        ],
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(child: widget),
                        ),
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
            top: showAppBar ? 0 : -120,
            curve: Curves.ease,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 25,
                top: MediaQuery.of(context).padding.top + 10,
              ),
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
              child: Text(
                'Challenge',
                textAlign: TextAlign.center,
                style: AppTextStyles.blackExtraBold18.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: MediaQuery.of(context).viewPadding.top,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: AppIconButton(
                onTap: () => GoRouter.of(context).pop(),
                size: 45,
                iconSize: 22,
                fillColor: showAppBar ? AppColors.primary.withOpacity(0.1) : AppColors.white,
                icon: Icons.chevron_left_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
