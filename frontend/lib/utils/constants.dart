// ignore_for_file: constant_identifier_names

import 'package:know_waste/models/recycling_tool/recycling_tool.dart';
import 'package:know_waste/presentation/router/route_names.dart';
import 'package:know_waste/presentation/theme/src/app_icons.dart';
import 'package:know_waste/presentation/theme/theme.dart';

class AppConstants {
  static const featuredArticleHeight = 240.0;

  static const privacyPolicyUrl = 'https://waste-wise-d88a7.web.app/privacy-policy';

  static const recyclingTools = [
    RecyclingTool(
      uid: 'waste-scanner',
      title: 'Waste Scanner',
      tag: 'AI-Powered',
      image: AppImages.wasteScanner,
      icon: AppIcons.wasteScanner,
      about: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
      route: RouteNames.analyze,
      buttonText: 'Launch Scanner',
    ),
    RecyclingTool(
      uid: 'coming-soon',
      title: 'Coming Soon',
      tag: 'Stay tuned...',
      image: AppImages.comingSoon,
      icon: AppIcons.comingSoon,
      about: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
    ),
  ];
}
