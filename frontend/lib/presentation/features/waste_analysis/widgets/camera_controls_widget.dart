import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../shared/app_icon_button.dart';
import '../../../shared/bouncing.dart';
import '../../../theme/src/app_shadows.dart';

final cameraLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class CameraControlsWidget extends ConsumerWidget {
  const CameraControlsWidget({
    required this.controller,
    required this.onGallery,
    required this.onCapture,
    super.key,
  });

  final CameraController? controller;
  final VoidCallback onGallery;
  final Function(File) onCapture;

  FlashMode get currentMode {
    if (controller?.value.isInitialized ?? false) {
      return FlashMode.off;
    }

    return controller?.value.flashMode ?? FlashMode.off;
  }

  IconData _getFlashIcon() {
    return currentMode == FlashMode.off ? Icons.flash_off_rounded : Icons.flash_on_rounded;
  }

  Color _getFillColor() {
    return currentMode == FlashMode.off ? Colors.white : const Color(0xff007029);
  }

  Color _getColor() {
    return currentMode == FlashMode.off ? const Color(0xff007029) : Colors.white;
  }

  void _toggleFlashMode() {
    final newMode = currentMode == FlashMode.torch ? FlashMode.off : FlashMode.torch;
    controller!.setFlashMode(newMode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 12, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 80),
              children: [
                AppIconButton(
                  onTap: onGallery,
                  icon: Icons.photo_rounded,
                ),
                Bouncing(
                  onTap: () async {
                    if (controller!.value.isTakingPicture) {
                      return;
                    }
                    controller!.pausePreview();
                    ref.read(cameraLoadingProvider.notifier).state = true;
                    final capturedFile = await controller!.takePicture();
                    await Future.delayed(const Duration(milliseconds: 300));
                    onCapture.call(File(capturedFile.path));
                    ref.read(cameraLoadingProvider.notifier).state = false;
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(width: 0.4, color: const Color(0xffCFE1D6)),
                    ),
                    child: Container(
                      padding: ref.watch(cameraLoadingProvider) ? const EdgeInsets.all(18) : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: const Color(0xff0AC64F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [AppShadows.primary],
                      ),
                      child: ref.watch(cameraLoadingProvider)
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Icon(
                              Icons.center_focus_strong_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                AppIconButton(
                  icon: _getFlashIcon(),
                  fillColor: _getFillColor(),
                  color: _getColor(),
                  onTap: _toggleFlashMode,
                ),
              ],
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 30,
                child: FadeInAnimation(child: widget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
