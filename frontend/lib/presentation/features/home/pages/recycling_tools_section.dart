import 'package:flutter/material.dart';
import 'package:know_waste/utils/constants.dart';

import '../../../theme/theme.dart';
import '../widgets/recycling_tool_widget.dart';

class RecyclingToolsSection extends StatelessWidget {
  const RecyclingToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recycling Tools',
            style: AppTextStyles.blackBlack22.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          // TODO: consider possibility moving tools to Firestore
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppConstants.recyclingTools.length,
            itemBuilder: (context, index) => RecyclingToolWidget(recyclingTool: AppConstants.recyclingTools[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          ),
        ],
      ),
    );
  }
}
