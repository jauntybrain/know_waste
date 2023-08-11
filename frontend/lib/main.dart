// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'providers/providers_logger.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/src/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final sharedPrefs = SharedPrefsService();
  // await sharedPrefs.init();

  runApp(
    ProviderScope(
      observers: [ProvidersLogger()],
      overrides: [
        // storageServiceProvider.overrideWithValue(sharedPrefs),
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
          router ??= AppRouter(ref);

          return MaterialApp.router(
            title: 'KnowWaste',
            debugShowCheckedModeBanner: false,
            routerDelegate: router!.appRouter.routerDelegate,
            routeInformationParser: router!.appRouter.routeInformationParser,
            routeInformationProvider:
                router!.appRouter.routeInformationProvider,
            theme: AppThemes.primary(),
          );
        },
      );
}
