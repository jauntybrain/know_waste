import 'package:flutter/material.dart';

import '../theme/src/app_colors.dart';
import '../theme/src/app_text_styles.dart';

class AppSearchWidget extends StatefulWidget {
  const AppSearchWidget({
    Key? key,
    this.autofocus = false,
    this.hint,
    this.onSearch,
    this.onSubmit,
    this.onFilter,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  final bool autofocus;
  final String? hint;
  final Function(String value)? onSearch;
  final Function(String value)? onSubmit;
  final VoidCallback? onFilter;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  FocusNode node = FocusNode();

  @override
  void initState() {
    if (widget.autofocus) {
      node.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.onTap != null,
        autofocus: widget.autofocus,
        focusNode: node,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        style: AppTextStyles.grayRegular16.copyWith(
          height: 1.5,
          color: Colors.black,
        ),
        onFieldSubmitted: widget.onSubmit,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.secondary,
            size: 25,
          ),
          hintStyle: AppTextStyles.blackRegular16.copyWith(color: AppColors.secondary.withOpacity(0.5)),
          filled: true,
          fillColor: widget.backgroundColor ?? AppColors.primary.withOpacity(0.1),
          hintText: widget.hint ?? 'Search',
          counterText: '',
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCFE1D6), width: 0.4),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.5), width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
        cursorWidth: 1.5,
        cursorColor: AppColors.secondary,
        onChanged: widget.onSearch,
        keyboardType: TextInputType.text,
        autocorrect: false,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
