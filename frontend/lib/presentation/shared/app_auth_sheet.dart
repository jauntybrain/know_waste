import 'package:flutter/material.dart';

import '../theme/theme.dart';

enum AuthSheetPages { login, register, forgotPassword, resetPassword }

// TODO: Implement this for email login
class AppAuthSheet {
  const AppAuthSheet(this.context);
  final BuildContext context;

  static AppAuthSheet of(BuildContext context) {
    return AppAuthSheet(context);
  }

  void show({
    String? title,
    String? emoji,
    AuthSheetPages initialPage = AuthSheetPages.login,
    String? token,
  }) {
    _showBottomSheet(context, title, emoji, initialPage, token);
  }

  void _showBottomSheet(context, title, emoji, initialPage, token) {
    AuthSheetPages currentPage = initialPage;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width > 1000 ? 500 : double.infinity,
      ),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      routeSettings: const RouteSettings(name: '/auth_sheet'),
      builder: (context) {
        final offset = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(bottom: offset),
          child: StatefulBuilder(
            builder: (context, setState) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Wrap(
                    children: [
                      Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
