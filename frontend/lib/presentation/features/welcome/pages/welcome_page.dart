import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/presentation/theme/theme.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text('Welcome'),
              const SizedBox(height: 50),
              AppButton.primary(
                child: const Text('Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
