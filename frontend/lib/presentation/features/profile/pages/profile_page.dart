// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/profile_item.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/package_info_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../router/route_names.dart';
import '../../../shared/app_icon_button.dart';
import '../../../shared/app_loading_dialog.dart';
import '../../../shared/app_toast.dart';
import '../../../shared/bouncing.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_text_styles.dart';
import '../widgets/auth_prompt_widget.dart';
import '../widgets/profile_tile.dart';

const profileItems = [
  ProfileItem(
    icon: Icons.settings_rounded,
    title: 'Settings',
    subtitle: 'Configure app settings',
    routeName: RouteNames.settings,
  ),
  ProfileItem(
    icon: Icons.question_answer_rounded,
    title: 'Help and support',
    subtitle: 'Find out more about KnowWaste',
    routeName: RouteNames.help,
  ),
  ProfileItem(
    icon: Icons.inventory_2_rounded,
    title: 'Your scans',
    subtitle: 'Check out your waste scans',
    routeName: RouteNames.analyzedWaste,
  ),
  ProfileItem(
    icon: Icons.logout_rounded,
    title: 'Sign out',
    subtitle: 'Log out from your current account',
    routeName: 'logout',
    hasChevron: false,
    registeredOnly: true,
  ),
];

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnonymous = FirebaseAuth.instance.currentUser?.isAnonymous ?? true;
    final currentUser = ref.watch(userProvider);

    ref.listen(authProvider, (prev, next) {
      if (next is AsyncLoading) {
        AppDialog.of(context).loading();
        return;
      } else if (prev is AsyncLoading) {
        AppDialog.dispose();
      }

      if (next is AsyncError) {
        AppToast.of(context).show(text: 'An issue occured, please try again', isError: true);
      }
    });

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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 20),
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 65),
                  AnimationConfiguration.synchronized(
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 300),
                      scale: 0.8,
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 160,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/dots.svg',
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/dotted_border.svg',
                                    color: AppColors.secondary,
                                    height: 140,
                                    width: 140,
                                  ),
                                  Container(
                                    height: 140,
                                    width: 140,
                                    padding: const EdgeInsets.all(10),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 200),
                                      child: currentUser?.profilePicture != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: currentUser!.profilePicture!,
                                                height: 140,
                                                width: 140,
                                                placeholder: (context, url) => const CircularProgressIndicator(),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/default-avatar.svg',
                                              height: 140,
                                              width: 140,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Bouncing(
                                        onTap: () => GoRouter.of(context).pushNamed(RouteNames.editProfile),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            border: Border.all(color: AppColors.background, width: 3),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentUser?.name ?? 'Anonymous user',
                            style: AppTextStyles.blackBold22.copyWith(height: 1, fontSize: 19),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '@${currentUser?.username ?? 'anonymous'}',
                            style: AppTextStyles.grayMedium16.copyWith(color: const Color(0xffB4B4B4)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  if (isAnonymous)
                    AuthPromptWidget(
                      onRegister: () {
                        // TODO: Introduce email sign up in the future
                        AppToast.of(context).show(
                          text: 'Coming soon!',
                          icon: Icons.hourglass_top_rounded,
                          gravity: ToastGravity.BOTTOM,
                        );
                      },
                    ),
                  const SizedBox(height: 5),
                  ListView.builder(
                    itemCount: profileItems.where((element) => isAnonymous ? !element.registeredOnly : true).length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        horizontalOffset: 80,
                        child: FadeInAnimation(
                          child: ProfileTile(
                            profileItem: profileItems[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Made with 💚',
                    style: AppTextStyles.black60Medium13,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ver. ${ref.read(packageInfoProvider).version}',
                    style: AppTextStyles.black60Medium13.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 55,
                  child: FadeInAnimation(child: widget),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 12,
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  color: AppColors.background.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: AppTextStyles.blackBlack22,
                      ),
                      AppIconButton(
                        onTap: () => GoRouter.of(context).pushNamed(RouteNames.notifications),
                        size: 45,
                        iconSize: 22,
                        fillColor: AppColors.primary.withOpacity(0.1),
                        icon: Icons.notifications_rounded,
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
