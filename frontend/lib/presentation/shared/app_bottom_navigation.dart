// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_wrapper_manager.dart';
import '../theme/theme.dart';

final bottomBarIndexProvider = StateProvider<int>((ref) => 0);

class AppBottomNavigation extends ConsumerWidget {
  const AppBottomNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            border: const Border(
              top: BorderSide(width: 1, color: Color(0xFFF2F2F2)),
            ),
          ),
          child: SafeArea(
            child: Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
              ),
              child: SizedBox(
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: BottomNavigationBar(
                    iconSize: 0,
                    elevation: 0.0,
                    type: BottomNavigationBarType.fixed,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                    currentIndex: navigationShell.currentIndex,
                    enableFeedback: true,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    backgroundColor: Colors.transparent,
                    unselectedItemColor: AppColors.secondary.withOpacity(0.5),
                    fixedColor: AppColors.secondary,
                    unselectedLabelStyle: AppTextStyles.blackBold14.copyWith(fontSize: 12, height: 1.6),
                    selectedLabelStyle: AppTextStyles.blackExtraBold16.copyWith(fontSize: 12, height: 1.6),
                    onTap: (index) {
                      HapticFeedback.lightImpact();
                      navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
                    },
                    items: List.generate(
                      AppWrapperManager.tabItems.length,
                      (i) {
                        final tabItem = AppWrapperManager.tabItems[i];
                        return BottomNavigationBarItem(
                          activeIcon: tabItem.activeIcon,
                          icon: tabItem.icon,
                          label: tabItem.label,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
