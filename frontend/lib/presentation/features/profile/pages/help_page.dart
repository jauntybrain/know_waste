import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/constants.dart';
import '../../../router/route_names.dart';
import '../../../shared/app_icon_button.dart';
import '../../../shared/bouncing.dart';
import '../../../shared/content_box.dart';
import '../../../theme/theme.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
                    SizedBox(height: MediaQuery.of(context).viewPadding.top + 55),
                    Bouncing(
                      onTap: () => launchUrlString('mailto:jauntybrain@gmail.com'),
                      child: ContentBox(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                              ),
                              child: const Icon(
                                Icons.mail_outline_rounded,
                                color: AppColors.secondary,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact',
                                    style: AppTextStyles.blackExtraBold15,
                                  ),
                                  Text(
                                    'For questions, proposals, and more',
                                    style: AppTextStyles.lightGrayRegular14
                                        .copyWith(fontSize: 13, color: Colors.black.withOpacity(0.8), height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.open_in_new, color: AppColors.secondary),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Bouncing(
                      onTap: () => launchUrlString('mailto:jauntybrain@gmail.com?subject=KnowWaste%20bug%20report&'
                          'body=Please%20describe%20the%20bug%20you%20found%20in%20the%20application.%20Thank%20you!'),
                      child: ContentBox(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                              ),
                              child: const Icon(
                                Icons.bug_report_outlined,
                                color: AppColors.secondary,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Report a bug',
                                    style: AppTextStyles.blackExtraBold15,
                                  ),
                                  Text(
                                    'Found a problem? Please let me know!',
                                    style: AppTextStyles.lightGrayRegular14
                                        .copyWith(fontSize: 13, color: Colors.black.withOpacity(0.8), height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.open_in_new, color: AppColors.secondary),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Bouncing(
                      onTap: () => GoRouter.of(context).goNamed(RouteNames.attributions),
                      child: ContentBox(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                              ),
                              child: const Icon(
                                Icons.info_outline_rounded,
                                color: AppColors.secondary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Third-Party services',
                                    style: AppTextStyles.blackExtraBold15,
                                  ),
                                  Text(
                                    'Check out these awesome resources I used',
                                    style: AppTextStyles.lightGrayRegular14
                                        .copyWith(fontSize: 13, color: Colors.black.withOpacity(0.8), height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xffe8e8e8),
                      thickness: 1,
                      height: 40,
                    ),
                    Bouncing(
                      onTap: () => launchUrlString(AppConstants.privacyPolicyUrl),
                      child: ContentBox(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                              ),
                              child: const Icon(
                                Icons.shield_outlined,
                                color: AppColors.secondary,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Privacy Policy',
                                    style: AppTextStyles.blackExtraBold15,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.open_in_new, color: AppColors.secondary),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
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
                      icon: Icons.chevron_left_rounded,
                    ),
                    Text(
                      'Help & Support',
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
