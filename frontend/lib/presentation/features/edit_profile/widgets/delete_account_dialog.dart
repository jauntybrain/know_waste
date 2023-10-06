import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class DeleteAccountDialog {
  const DeleteAccountDialog(this.context);
  final BuildContext context;

  static DeleteAccountDialog of(BuildContext context) {
    return DeleteAccountDialog(context);
  }

  Future<String?> show() async {
    return _showDialog(context);
  }

  Future<String?> _showDialog(context) async {
    final offset = MediaQuery.of(context).viewInsets.bottom;
    final controller = TextEditingController();

    return showModalBottomSheet<String?>(
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
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Delete account',
                      style: AppTextStyles.blackBold20,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'This action is irreversible, all data will be lost. Enter your password to confirm.',
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
                            onTap: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButton.primary(
                            height: 50,
                            borderRadius: 10,
                            fillColor: const Color(0xFFFFCFCF),
                            textColor: AppColors.red,
                            onTap: () => Navigator.pop(context, controller),
                            child: const Text('Proceed'),
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
