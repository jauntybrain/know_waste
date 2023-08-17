import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class QuitChallengeDialog {
  const QuitChallengeDialog(this.context);
  final BuildContext context;

  static QuitChallengeDialog of(BuildContext context) {
    return QuitChallengeDialog(context);
  }

  Future<bool?> show() async {
    return _showDialog(context);
  }

  Future<bool?> _showDialog(context) async {
    final offset = MediaQuery.of(context).viewInsets.bottom;

    return showModalBottomSheet<bool?>(
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.secondary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Quit challenge?',
                      style: AppTextStyles.blackBold20,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Are you sure you want to quit this challenge? This action is irreversible, all progress will be lost.',
                      style: AppTextStyles.grayMedium14,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppButton.primary(
                            height: 50,
                            borderRadius: 10,
                            onTap: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButton.secondary(
                            height: 50,
                            borderRadius: 10,
                            onTap: () => Navigator.pop(context, true),
                            child: const Text('Quit'),
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
