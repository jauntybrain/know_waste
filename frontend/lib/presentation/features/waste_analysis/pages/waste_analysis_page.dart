import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/app_toast.dart';
import '../../../theme/theme.dart';
import '../providers/waste_analysis_provider.dart';
import '../widgets/camera_controls_widget.dart';
import '../widgets/restart_analysis_dialog.dart';
import '../widgets/waste_analysis_top_nav.dart';
import 'waste_analysis_camera_page.dart';
import 'waste_analysis_loading_page.dart';
import 'waste_analysis_result_page.dart';

class WasteAnalysisPage extends ConsumerStatefulWidget {
  const WasteAnalysisPage({Key? key}) : super(key: key);

  @override
  WasteAnalysisPageState createState() => WasteAnalysisPageState();
}

class WasteAnalysisPageState extends ConsumerState<WasteAnalysisPage> {
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    CameraDescription description = await availableCameras().then((cameras) => cameras[0]);
    _cameraController = CameraController(
      description,
      enableAudio: false,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (_cameraController!.value.hasError) {
        AppToast.of(context).show(text: 'Camera error, try again');
      }
    });

    try {
      await _cameraController!.initialize();
      _cameraController!
        ..lockCaptureOrientation(DeviceOrientation.portraitUp)
        ..setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      switch (e.code) {
        // TODO: Add error dialog
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final wasteAnalysis = ref.watch(wasteAnalysisProvider);
    final hasData = wasteAnalysis.analyzedWaste != null;
    final isLoading = wasteAnalysis.loading;

    ref.listen(wasteAnalysisProvider, (prev, next) {
      if (next.error != null) {
        _cameraController?.resumePreview();
        AppToast.of(context).show(
          isError: true,
          text: next.error.toString(),
        );
      }
    });

    List<Widget> buildBackground() => [
          Positioned.fill(
            child: _cameraController == null ||
                    !(_cameraController?.value.isInitialized ?? true) ||
                    wasteAnalysis.analyzedWaste != null
                ? Container(color: AppColors.white)
                : wasteAnalysis.pickedImage != null
                    ? Image.file(
                        wasteAnalysis.pickedImage!,
                        fit: BoxFit.cover,
                      )
                    : AspectRatio(
                        aspectRatio: _cameraController!.value.aspectRatio,
                        child: CameraPreview(_cameraController!),
                      ),
          ),
        ];

    Widget buildAnalysisBottomNav() => Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 10,
              top: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [AppShadows.primary],
            ),
            child: Column(
              children: [
                AppButton.primary(
                  onTap: () {
                    ref.read(wasteAnalysisProvider.notifier).reset();
                    GoRouter.of(context).pop();
                  },
                  hasShadow: false,
                  fillColor: AppColors.secondary,
                  height: 50,
                  child: const Text('Understood!'),
                ),
                const SizedBox(height: 10),
                AppButton.secondary(
                  onTap: () => RestartAnalysisDialog.of(context).show().then(
                    (value) {
                      if (value == true) {
                        ref.read(wasteAnalysisProvider.notifier).restart();
                      }
                    },
                  ),
                  height: 50,
                  child: const Text('Wrong object or material?'),
                ),
              ],
            ),
          ),
        );

    Widget buildContent() {
      if (hasData && !isLoading) {
        return const WasteAnalysisResultPage();
      } else {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + 75,
            bottom: MediaQuery.of(context).viewPadding.bottom + (wasteAnalysis.loading ? 10 : 110),
            left: 18,
            right: 18,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Show background photo
                  if (wasteAnalysis.pickedImage != null)
                    Positioned.fill(
                      child: Image.file(
                        wasteAnalysis.pickedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  // If loading, show loading indicator and tip
                  if (isLoading) ...[
                    const WasteAnalysisLoadingPage(),
                    // TODO: Bring back tips later
                    // const RecyclingTipWidget(),

                    // If camera is initialized, show camera preview
                  ] else if (_cameraController?.value.lockedCaptureOrientation != null)
                    WasteAnalysisCameraPage(
                      controller: _cameraController,
                      pickedImage: wasteAnalysis.pickedImage,
                    )
                  // Default: show loading Shimmer
                  else
                    Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.08),
                      child: Container(width: 200, height: 200, color: AppColors.white),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            ...buildBackground(),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Container(
                  color: AppColors.white.withOpacity(0.85),
                  width: double.infinity,
                ),
              ),
            ),
            // Main Page Content
            Positioned.fill(child: buildContent()),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: WasteAnalysisTopNav(
                blurred: hasData,
                onClose: ref.read(wasteAnalysisProvider.notifier).reset,
              ),
            ),
            // Camera Controls
            if (wasteAnalysis.pickedImage == null && !isLoading)
              Positioned(
                bottom: MediaQuery.of(context).viewPadding.bottom,
                width: MediaQuery.of(context).size.width,
                child: CameraControlsWidget(
                  controller: _cameraController,
                  onCapture: (image) {
                    _cameraController!.setFlashMode(FlashMode.off);
                    ref.read(wasteAnalysisProvider.notifier)
                      ..setPickedImage(image)
                      ..uploadImage();
                  },
                  onGallery: () => ref.read(wasteAnalysisProvider.notifier).pickImage(isCamera: false),
                ),
              ),
            // Bottom Navigation
            if (wasteAnalysis.analyzedWaste != null && !isLoading) buildAnalysisBottomNav(),
          ],
        ),
      ),
    );
  }
}
