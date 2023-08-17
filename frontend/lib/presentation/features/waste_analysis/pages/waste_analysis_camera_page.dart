import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraFlashProvider = StateProvider.autoDispose<FlashMode>((ref) => FlashMode.auto);

GlobalKey stickyKey = GlobalKey();

class WasteAnalysisCameraPage extends ConsumerStatefulWidget {
  const WasteAnalysisCameraPage({required this.controller, this.pickedImage, Key? key}) : super(key: key);

  final CameraController? controller;
  final File? pickedImage;

  @override
  WasteAnalysisCameraPageState createState() => WasteAnalysisCameraPageState();
}

class WasteAnalysisCameraPageState extends ConsumerState<WasteAnalysisCameraPage> {
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    _initializeZoom();
    super.initState();
  }

  void _initializeZoom() async {
    await Future.wait(<Future<Object?>>[
      widget.controller!.getMaxZoomLevel().then((double value) => _maxAvailableZoom = value),
      widget.controller!.getMinZoomLevel().then((double value) => _minAvailableZoom = value),
    ]);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (widget.controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale).clamp(_minAvailableZoom, _maxAvailableZoom);

    await widget.controller!.setZoomLevel(_currentScale);
    setState(() {});
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (widget.controller == null) {
      return;
    }

    final CameraController cameraController = widget.controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(cameraFlashProvider, (prev, next) {
    //   if (next != prev) {
    //     widget.controller?.setFlashMode(next);
    //   }
    // });

    return Listener(
      onPointerDown: (_) => _pointers++,
      onPointerUp: (_) => _pointers--,
      child: Transform.scale(
        scale: 1.0,
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: 1,
                width: 0.6,
                child: CameraPreview(
                  widget.controller!,
                  key: stickyKey,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onScaleStart: _handleScaleStart,
                        onScaleUpdate: _handleScaleUpdate,
                        onTapDown: (TapDownDetails details) => onViewFinderTap(details, constraints),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
