import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:know_waste/presentation/shared/app_icon_button.dart';

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
                  icon:
                      controller?.value.flashMode == FlashMode.auto ? Icons.flash_off_rounded : Icons.flash_on_rounded,
                  fillColor: controller?.value.flashMode == FlashMode.auto ? Colors.white : const Color(0xff007029),
                  color: controller?.value.flashMode == FlashMode.auto ? const Color(0xff007029) : Colors.white,
                  onTap: () {
                    controller?.setFlashMode(
                        controller!.value.flashMode == FlashMode.torch ? FlashMode.off : FlashMode.torch);
                  },
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
