import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/user_provider.dart';
import '../../../shared/content_box.dart';
import '../../../theme/theme.dart';
import '../widgets/stats_widget.dart';

class StatsSection extends ConsumerWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your stats',
            style: AppTextStyles.blackBlack22.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: ContentBox(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Items',
                        style: AppTextStyles.blackBlack22.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${currentUser?.stats?.total ?? 0}',
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 20, height: 1.2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ContentBox(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Rating',
                        style: AppTextStyles.blackBlack22.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Top ${currentUser?.stats?.rank.round() ?? 100}%',
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 20, height: 1.2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            children: [
              const SizedBox(width: 20),
              StatsWidget(
                color: const Color(0xff4462FF),
                icon: AppIcons.plastic,
                label: 'Plastic waste',
                value: currentUser?.stats?.plastic ?? 0,
              ),
              const SizedBox(width: 10),
              StatsWidget(
                color: const Color(0xff3DA171),
                icon: AppIcons.glass,
                label: 'Glass waste',
                value: currentUser?.stats?.glass ?? 0,
              ),
              const SizedBox(width: 10),
              StatsWidget(
                color: const Color(0xffE89559),
                icon: AppIcons.paper,
                label: 'Paper',
                value: currentUser?.stats?.paper ?? 0,
              ),
              const SizedBox(width: 10),
              StatsWidget(
                color: const Color(0xff565B76),
                icon: AppIcons.electronics,
                label: 'Electronics',
                value: currentUser?.stats?.electronics ?? 0,
              ),
              const SizedBox(width: 10),
              StatsWidget(
                color: const Color(0xffA13D61),
                icon: AppIcons.other,
                label: 'Other',
                value: currentUser?.stats?.other ?? 0,
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
