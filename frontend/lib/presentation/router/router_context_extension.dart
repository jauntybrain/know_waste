import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

/// [RouterContextExtension] is an extension on [BuildContext] to simplify navigation.
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void goHome({
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(
      RouteNames.home,
      queryParameters: queryParams,
      extra: extra,
    );
  }
}
