import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/theme.dart';

class AppToast {
  const AppToast(this.context);
  final BuildContext context;

  static AppToast of(BuildContext context) {
    return AppToast(context);
  }

  void show({
    required String text,
    Color fillColor = Colors.greenAccent,
    Color textColor = Colors.black,
    IconData icon = Icons.check_rounded,
    ToastGravity gravity = ToastGravity.TOP,
    bool isError = false,
    bool isLong = false,
    String? emoji,
    Duration? duration,
  }) {
    final fToast = FToast()..init(context);
    fToast.removeQueuedCustomToasts();

    Widget child = Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.whiteBold16.copyWith(
        color: isError ? Colors.white : textColor,
        height: 1.6,
      ),
    );

    Widget toast = Container(
      margin: const EdgeInsets.only(bottom: 70),
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isLong ? 12 : 60),
        color: isError ? Colors.redAccent : fillColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? Icons.warning_rounded : icon,
            color: isError ? Colors.white : textColor,
          ),
          if (emoji != null)
            Text(
              emoji,
              style: AppTextStyles.whiteSemiBold16.copyWith(height: 1.6),
            ),
          const SizedBox(width: 12.0),
          isLong ? Expanded(child: child) : child,
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration ?? const Duration(seconds: 2),
    );
  }
}
