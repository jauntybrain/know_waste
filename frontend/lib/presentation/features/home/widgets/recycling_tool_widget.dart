import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/recycling_tool/recycling_tool.dart';
import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';

class RecyclingToolWidget extends StatelessWidget {
  const RecyclingToolWidget({required this.recyclingTool, super.key});

  final RecyclingTool recyclingTool;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0xfff2f2f2)),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [AppShadows.small],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  AppImages.image(recyclingTool.image),
                  Positioned.fill(child: ColoredBox(color: Colors.black.withOpacity(0.2))),
                  Positioned(
                    bottom: -25,
                    left: 20,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xfff2f2f2)),
                        boxShadow: [AppShadows.small],
                      ),
                      child: AppIcons.icon(
                        recyclingTool.icon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    recyclingTool.tag,
                    style: AppTextStyles.blackBlack22.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    recyclingTool.title,
                    style: AppTextStyles.blackBlack22.copyWith(fontSize: 20, height: 1.2),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recyclingTool.about,
                    style: AppTextStyles.grayMedium16,
                  ),
                  if (recyclingTool.route != null) ...[
                    const SizedBox(height: 15),
                    AppButton.primary(
                      onTap: () => GoRouter.of(context).pushNamed(recyclingTool.route!),
                      hasShadow: false,
                      fillColor: AppColors.secondary.withOpacity(0.2),
                      height: 52,
                      child: Text(
                        recyclingTool.buttonText ?? 'Launch',
                        style: AppTextStyles.blackExtraBold16.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
