import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class TutorialDialog {
  const TutorialDialog(this.context);
  final BuildContext context;

  static TutorialDialog of(BuildContext context) {
    return TutorialDialog(context);
  }

  void show() {
    _showDialog(context);
  }

  void _showDialog(context) {
    final offset = MediaQuery.of(context).viewInsets.bottom;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: offset + (offset < 10 ? 10 : 0),
                left: 10,
                right: 10,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppIcons.icon(AppIcons.wasteScanner),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'How does it work?',
                      style: AppTextStyles.blackBlack22,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Waste Scanner uses AI image labeling, object recognition, and language tasks in order to process the photo and provide the analysis with recycling advice and useful tips.',
                      style: AppTextStyles.grayMedium16,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Tutorial',
                      style: AppTextStyles.blackBlack22,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'For the best result, try keeping only one object in the photo, and make it clearly visible. Please don\'t forget that the algorithm can sometimes make mistakes.',
                      style: AppTextStyles.grayMedium16,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppButton.secondary(
                            height: 50,
                            borderRadius: 100,
                            onTap: () => Navigator.pop(context),
                            child: const Text('Got it!'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
