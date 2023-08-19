import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:know_waste/models/challenge/challenge.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';
import 'package:know_waste/utils/extensions.dart';

import '../../../../theme/theme.dart';

class ChallengeWidget extends StatelessWidget {
  const ChallengeWidget({
    required this.challenge,
    this.onTap,
    super.key,
  });

  final Challenge challenge;
  final Function(Challenge)? onTap;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: () => onTap?.call(challenge),
      child: Wrap(
        children: [
          Container(
            width: 220,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xfff2f2f2)),
              boxShadow: [AppShadows.primary],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: ColoredBox(
                            color: challenge.color.hexToColor().withOpacity(0.2),
                          ),
                        ),
                        Positioned(
                          child: CachedNetworkImage(
                            imageUrl: challenge.iconUrl,
                            height: 90,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.tool,
                        style: AppTextStyles.blackBlack22.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        challenge.title,
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 18),
                      ),
                      Text(
                        challenge.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.grayMedium14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
