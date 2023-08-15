import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:know_waste/presentation/features/community/pages/sections/community_challenges_section.dart';
import 'package:know_waste/presentation/features/home/pages/recycling_tools_section.dart';
import 'package:know_waste/presentation/features/home/widgets/home_app_bar.dart';
import 'package:know_waste/presentation/theme/theme.dart';

import '../widgets/home_recommended_tool_widget.dart';

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Your stats',
                        style: AppTextStyles.blackBlack22.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xfff2f2f2)),
                          boxShadow: [AppShadows.small],
                        ),
                      ),
                    ),
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
