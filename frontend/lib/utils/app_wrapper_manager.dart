import 'package:flutter/material.dart';
import 'package:know_waste/presentation/theme/theme.dart';

import '../models/tab_item_id.dart';
import '../presentation/router/route_names.dart';

class AppWrapperManager {
  static List<TabItem> tabItems = [
    const TabItem(
      id: TabItemId.home,
      route: RouteNames.home,
      label: 'Home',
      icon: Icon(
        Icons.home_rounded,
        size: 24,
        color: Color(0x73008731),
      ),
      activeIcon: Icon(
        Icons.home_rounded,
        size: 24,
        color: AppColors.secondary,
      ),
    ),
    const TabItem(
      id: TabItemId.analyze,
      route: RouteNames.analyze,
      label: 'Analyze',
      icon: Icon(
        Icons.recycling_rounded,
        size: 24,
        color: Color(0x73008731),
      ),
      activeIcon: Icon(
        Icons.recycling_rounded,
        size: 24,
        color: AppColors.secondary,
      ),
    ),
    const TabItem(
      id: TabItemId.community,
      route: RouteNames.community,
      label: 'Community',
      icon: Icon(
        Icons.people_alt_rounded,
        size: 24,
        color: Color(0x73008731),
      ),
      activeIcon: Icon(
        Icons.people_alt_rounded,
        size: 24,
        color: AppColors.secondary,
      ),
    ),
  ];
}
