import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/src/app_colors.dart';

class ChallengeAppBar extends StatelessWidget {
  const ChallengeAppBar({
    required this.background,
    required this.medal,
    required this.color,
    super.key,
  });

  final String background, medal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 160,
      backgroundColor: AppColors.background,
      stretch: true,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: FlexibleSpaceBar(
              expandedTitleScale: 1.1,
              stretchModes: const [StretchMode.zoomBackground, StretchMode.fadeTitle],
              centerTitle: true,
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: background,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0),
                            color.withOpacity(0.2),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 1],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: 20,
            child: CachedNetworkImage(
              imageUrl: medal,
              height: 135,
            ),
          ),
        ],
      ),
    );
  }
}
