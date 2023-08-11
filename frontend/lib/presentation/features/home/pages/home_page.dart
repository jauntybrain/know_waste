import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/router/route_names.dart';
import 'package:know_waste/presentation/theme/theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Good morning, Pavel',
          style: AppTextStyles.blackBlack22,
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.5,
        shadowColor: Colors.black.withOpacity(0.2),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: AppButton.primary(
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteNames.analyze);
                  },
                  hasShadow: false,
                  fillColor: const Color(0xff99EFB9),
                  textColor: AppColors.secondary,
                  child: const Text('Analyze item'),
                ),
              ),
              // const SizedBox(
              //   height: 600,
              //   width: double.infinity,
              //   child: WasteAnalysisPage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
