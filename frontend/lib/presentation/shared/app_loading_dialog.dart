import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppDialog {
  const AppDialog(this.context);
  final BuildContext context;

  static AppDialog of(BuildContext context) {
    return AppDialog(context);
  }

  static IDialog? _current;

  Future<void> loading() async {
    _current = LoadingDialog();

    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(kIsWeb ? 0.7 : 0.4),
      builder: (context) => _current ?? LoadingDialog(),
    );
  }

  static void dispose() {
    if (_current != null) {
      _current?.dismiss();
      _current = null;
    }
  }
}

mixin IDialogService {
  void dismiss();
}

abstract class IDialog extends StatelessWidget with IDialogService {
  const IDialog({Key? key}) : super(key: key);
}

// ignore: must_be_immutable
class LoadingDialog extends IDialog {
  final String? title;
  LoadingDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.secondary),
          ),
        ),
      ),
    );
  }

  @override
  void dismiss() {
    Navigator.pop(_context!);
  }
}
