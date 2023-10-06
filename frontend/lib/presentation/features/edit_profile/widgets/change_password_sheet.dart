import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../shared/app_text_field.dart';
import '../../../shared/app_toast.dart';
import '../../../theme/theme.dart';
import '../providers/edit_profile_controller.dart';

class ChangePasswordSheet {
  const ChangePasswordSheet(this.context);
  final BuildContext context;

  static ChangePasswordSheet of(BuildContext context) {
    return ChangePasswordSheet(context);
  }

  void show() {
    _showBottomSheet(context);
  }

  void _showBottomSheet(context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var oldPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final offset = MediaQuery.of(context).viewInsets.bottom;
          final userState = ref.watch(editProfileControllerProvider);
          final isLoading = userState is AsyncLoading;
          final isError = userState is AsyncError && userState.error is ApiError;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: offset + (offset < 10 ? 10 : 0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 4,
                            width: 65,
                            color: const Color(0xffE8E8E8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Change password',
                          style: AppTextStyles.blackBold20,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Enter your old and new passwords in order to change your login.',
                          style: AppTextStyles.grayMedium16,
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          textController: oldPasswordController,
                          label: 'Old password',
                          hintText: '********',
                          isDisabled: isLoading,
                          fillColor: AppColors.background,
                          validator: (value) {
                            return value!.isEmpty ? 'This field is required' : null;
                          },
                        ),
                        const SizedBox(height: 15),
                        AppTextField(
                          textController: newPasswordController,
                          label: 'New password',
                          hintText: '********',
                          isDisabled: isLoading,
                          fillColor: AppColors.background,
                          validator: (value) {
                            bool passwordValid = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}").hasMatch(value!);
                            return value.isEmpty
                                ? 'This field is required'
                                : oldPasswordController.text == value
                                    ? 'Passwords cannot be the same'
                                    : !passwordValid
                                        ? 'Password is too weak'
                                        : null;
                          },
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isError
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: null,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(60)),
                                    color: Color(0xffF4D9D9),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: AppColors.red,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        (userState.error as ApiError).message,
                                        textAlign: TextAlign.left,
                                        style: AppTextStyles.whiteMedium16.copyWith(color: AppColors.red),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(height: 20),
                        ),
                        AppButton.primary(
                          fillColor: AppColors.secondary,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              ref.read(editProfileControllerProvider.notifier).changePassword(
                                    oldPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text,
                                    onSuccess: () {
                                      AppToast.of(context).show(text: 'Password updated');
                                      context.pop();
                                    },
                                  );
                            }
                          },
                          isLoading: isLoading,
                          child: const Text('Change password'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
