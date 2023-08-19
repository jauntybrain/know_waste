import 'package:flutter/material.dart';

enum TabItemId {
  home,
  community,
  profile,
}

class TabItem {
  const TabItem({
    required this.id,
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final TabItemId id;
  final String route;
  final String label;
  final Widget icon;
  final Widget activeIcon;
}
