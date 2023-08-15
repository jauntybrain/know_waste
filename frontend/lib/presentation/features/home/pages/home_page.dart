import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:know_waste/presentation/features/community/pages/sections/community_challenges_section.dart';
import 'package:know_waste/presentation/features/home/pages/recycling_tools_section.dart';
import 'package:know_waste/presentation/features/home/widgets/home_app_bar.dart';

import '../widgets/home_recommended_tool_widget.dart';
import 'stats_section.dart';

final showAppbar = StateProvider.autoDispose<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: CustomScrollView(
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
    );
  }
}
