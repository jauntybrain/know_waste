import 'package:flutter/material.dart';

import '../../../shared/content_box.dart';
import '../../../theme/theme.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    required this.color,
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  final Color color;
  final String icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      height: 140,
      width: 140,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.toString(),
                      style: AppTextStyles.blackBlack22.copyWith(
                        fontSize: 24,
                        height: 1.2,
                        color: color,
                      ),
                    ),
                    Text(
                      label,
                      style: AppTextStyles.blackExtraBold22.copyWith(
                        fontWeight: FontWeight.w900,
                        color: color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -55,
              right: -40,
              child: AppIcons.icon(
                icon,
                color: color,
                size: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
