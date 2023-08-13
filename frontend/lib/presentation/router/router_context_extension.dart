import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/article/article.dart';
import 'route_names.dart';

/// [RouterContextExtension] is an extension on [BuildContext] to simplify navigation.
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void pushArticle(Article article) {
    GoRouter.of(this).goNamed(
      RouteNames.article,
      extra: article,
    );
  }
}
