// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/providers/package_info_provider.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'firebase_options.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/src/app_themes.dart';
import 'providers/providers_logger.dart';
import 'providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  final packageInfo = PackageInfoService();
  await packageInfo.init();

  runApp(
    ProviderScope(
      observers: [ProvidersLogger()],
      overrides: [
        packageInfoProvider.overrideWithValue(packageInfo),
      ],
      child: KnowWasteApp(),
    ),
  );
}

class KnowWasteApp extends StatelessWidget {
  KnowWasteApp({super.key});

  AppRouter? router;

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, ref, child) {
          ref.watch(userProvider);
          router ??= AppRouter(ref);

          return MaterialApp.router(
            title: 'KnowWaste',
            debugShowCheckedModeBanner: false,
            routerDelegate: router!.appRouter.routerDelegate,
            routeInformationParser: router!.appRouter.routeInformationParser,
            routeInformationProvider: router!.appRouter.routeInformationProvider,
            theme: AppThemes.primary(),
          );
        },
      );
}
