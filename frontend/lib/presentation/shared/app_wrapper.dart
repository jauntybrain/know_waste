import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_bottom_navigation.dart';

class AppWrapper extends ConsumerWidget {
  const AppWrapper({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Bouncing(
        //   onTap: () {},
        //   child: Container(
        //     width: 80,
        //     height: 80,
        //     margin: const EdgeInsets.only(bottom: 8),
        //     decoration: const BoxDecoration(
        //       color: AppColors.primary,
        //       shape: BoxShape.circle,
        //     ),
        //     child: const Icon(
        //       Icons.center_focus_strong_rounded,
        //       size: 35,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        bottomNavigationBar: AppBottomNavigation(navigationShell: navigationShell),
        extendBody: true,
        body: navigationShell,
      ),
    );
  }
}
