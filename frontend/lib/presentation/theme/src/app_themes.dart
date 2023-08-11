import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  static ThemeData primary({bool isDark = false}) {
    return ThemeData(
      useMaterial3: false,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.white,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.background,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.primary),
        titleTextStyle: AppTextStyles.blackRegular16.copyWith(
          color: AppColors.text,
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          border: Border.all(width: 0, color: Colors.transparent),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
      ),
      splashFactory: defaultTargetPlatform == TargetPlatform.iOS
          ? NoSplash.splashFactory
          : InkSplash.splashFactory,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
      ).copyWith(background: AppColors.background),
    );
  }
}
