import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_icon_button.dart';
import '../../../shared/app_markdown.dart';
import '../../../theme/theme.dart';

class AttributionsPage extends StatelessWidget {
  const AttributionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Page content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).viewPadding.top + 60),
                    Column(
                      children: [
                        Text(
                          'Several great resources were used to create this application. Thank you to the following third-party services for their attributions:',
                          style: AppTextStyles.blackBold16,
                        ),
                        const SizedBox(height: 15),
                        const AppMarkdown(
                          text: '* Some images are taken from [Unsplash](https://unsplash.com/).\n'
                              '* Some icons are from [FontAwesome](https://fontawesome.com/) and [Storyset](https://www.flaticon.com/).\n'
                              '* Font Lato is from [Google Fonts](https://fonts.google.com/).\n',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [AppShadows.small],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 12,
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      onTap: () => GoRouter.of(context).pop(),
                      size: 45,
                      iconSize: 22,
                      fillColor: AppColors.primary.withOpacity(0.1),
                      icon: Icons.close_rounded,
                    ),
                    Text(
                      'Attributions',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
