import 'package:flutter/material.dart';

import '../../../theme/src/app_icons.dart';
import '../../../theme/theme.dart';
import '../widgets/stats_widget.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xfff2f2f2)),
                    boxShadow: [AppShadows.small],
                  ),
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
                        '245',
                        style: AppTextStyles.blackBlack22.copyWith(fontSize: 20, height: 1.2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xfff2f2f2)),
                    boxShadow: [AppShadows.small],
                  ),
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
                        'Top 3%',
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
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: Row(
            children: [
              SizedBox(width: 20),
              StatsWidget(
                color: Color(0xffE89559),
                icon: AppIcons.plastic,
                label: 'Plastic waste',
                value: 69,
              ),
              SizedBox(width: 10),
              StatsWidget(
                color: Color(0xff3DA171),
                icon: AppIcons.glass,
                label: 'Glass waste',
                value: 117,
              ),
              SizedBox(width: 10),
              StatsWidget(
                color: Color(0xff4462FF),
                icon: AppIcons.paper,
                label: 'Paper',
                value: 0,
              ),
              SizedBox(width: 10),
              StatsWidget(
                color: Color(0xff565B76),
                icon: AppIcons.electronics,
                label: 'Electronics',
                value: 0,
              ),
              SizedBox(width: 10),
              StatsWidget(
                color: Color(0xffA13D61),
                icon: AppIcons.other,
                label: 'Other',
                value: 94,
              ),
              SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
