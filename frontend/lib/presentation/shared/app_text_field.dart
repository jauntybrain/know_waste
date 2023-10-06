import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? textController;
  final String? Function(String? value)? validator;
  final GlobalKey<FormState>? formKey;
  final FocusNode? formNode;
  final TextInputType? keyboardType;
  final String? helperText;
  final String? label;
  final String? description;
  final String? hintText;
  final bool? isPassword;
  final String? errorText;
  final Color? fillColor;
  final bool? ignoreOnChanged;
  final Function(String? value)? onChanged;
  final bool isDisabled;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final List<TextInputFormatter> inputFormatters;
  final Widget? icon;
  final TextInputAction? inputAction;
  final Function(String? value)? onSubmitted;
  final bool showCount;
  final bool isRequired;
  final List<String>? autofillHints;
  final Color? textColor;

  const AppTextField({
    Key? key,
    this.textController,
    this.validator,
    this.formKey,
    this.formNode,
    this.keyboardType,
    this.helperText,
    this.label,
    this.description,
    this.hintText,
    this.isPassword,
    this.errorText,
    this.fillColor,
    this.ignoreOnChanged,
    this.onChanged,
    this.isDisabled = false,
    this.initialValue,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.inputFormatters = const [],
    this.icon,
    this.inputAction,
    this.onSubmitted,
    this.showCount = false,
    this.isRequired = false,
    this.autofillHints,
    this.textColor,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              widget.label!,
              textAlign: TextAlign.start,
              style: AppTextStyles.blackSemiBold16.copyWith(color: widget.textColor ?? Colors.black),
            ),
          ),
        TextFormField(
          autofocus: widget.autofocus,
          autofillHints: widget.autofillHints,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          key: widget.formKey,
          focusNode: widget.formNode,
          controller: widget.textController,
          obscureText: widget.isPassword ?? false,
          maxLength: widget.maxLength ?? (widget.maxLines != null ? null : 150),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          initialValue: widget.initialValue,
          style: TextStyle(
            color: widget.isDisabled ? Colors.grey : Colors.black,
          ),
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            hintStyle: AppTextStyles.blackRegular16.copyWith(
              color: const Color(0xff9D9D9D),
            ),
            filled: true,
            fillColor: widget.fillColor ?? AppColors.white,
            helperText: widget.helperText,
            hintText: widget.hintText,
            errorMaxLines: 10,
            enabled: !widget.isDisabled,
            counterText: widget.showCount ? null : '',
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.background,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffe8e8e8),
                width: 1.2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.background,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondary,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
          cursorWidth: 1.5,
          cursorColor: AppColors.secondary,
          onChanged: widget.onChanged,
          validator: widget.validator == null && widget.isRequired
              ? (value) => value!.isEmpty ? 'This field is required' : null
              : widget.validator,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          autocorrect: false,
          textInputAction: widget.inputAction ?? TextInputAction.next,
        )
      ],
    );
  }
}
