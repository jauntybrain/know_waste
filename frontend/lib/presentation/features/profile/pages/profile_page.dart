import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/features/profile/widgets/join_prompt_widget.dart';

import '../../../../models/profile_item.dart';
import '../../../shared/app_icon_button.dart';
import '../../../theme/src/app_colors.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/src/app_text_styles.dart';
import '../widgets/profile_tile.dart';

const profileItems = [
  ProfileItem(
    icon: AppIcons.settings,
    title: 'Settings',
    subtitle: 'Configure app settings',
    routeName: '',
  ),
  ProfileItem(
    icon: AppIcons.help,
    title: 'Help and support',
    subtitle: 'Find out more about us',
    routeName: '',
  ),
  ProfileItem(
    icon: AppIcons.scans,
    title: 'Your scans',
    subtitle: 'Check out your waste scans',
    routeName: '',
  ),
  ProfileItem(
    icon: AppIcons.signIn,
    title: 'Sign out',
    subtitle: 'Log out from your current account',
    routeName: '',
    hasChevron: false,
    registeredOnly: true,
  ),
];

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 60),
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
                                  height: 140,
                                  width: 140,
                                  color: AppColors.secondary,
                                ),
                                Container(
                                  height: 140,
                                  width: 140,
                                  padding: const EdgeInsets.all(10),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: SvgPicture.asset(
                                      'assets/icons/default-avatar.svg',
                                      height: 140,
                                      width: 140,
                                    ),
                                    //  currentUser?.profilePicture != null
                                    //     ? ClipRRect(
                                    //         borderRadius: BorderRadius.circular(100),
                                    //         child: CachedNetworkImage(
                                    //           imageUrl: currentUser!.profilePicture!,
                                    //           height: 140,
                                    //           width: 140,
                                    //           placeholder: (context, url) => const CircularProgressIndicator(),
                                    //           fit: BoxFit.cover,
                                    //         ),
                                    //       )
                                    // : Image.asset('assets/images/default_avatar.png'),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        border: Border.all(color: AppColors.background, width: 3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          GoRouter.of(context).goNamed('');
                                        },
                                        borderRadius: BorderRadius.circular(60),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            size: 24,
                                            color: Colors.white,
                                          ),
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
                          'Anonymous user',
                          style: AppTextStyles.blackBold22.copyWith(height: 1, fontSize: 19),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '@anonymous',
                          style: AppTextStyles.grayMedium16.copyWith(color: const Color(0xffB4B4B4)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                JoinPromptWidget(openRegistration: () {}, openLogin: () {}),
                const SizedBox(height: 10),
                AnimationLimiter(
                  child: ListView.builder(
                    itemCount: profileItems.length,
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
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                  color: Color(0xffF3F3F3),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
              ],
            ),
          ),
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
                  color: AppColors.background.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: AppTextStyles.blackBlack22,
                      ),
                      AppIconButton(
                        onTap: () => GoRouter.of(context).pushNamed(''),
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
