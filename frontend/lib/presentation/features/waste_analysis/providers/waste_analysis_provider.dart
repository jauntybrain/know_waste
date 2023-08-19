import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/repositories/analyzed_waste/analyzed_waste_repository.dart';
import 'package:know_waste/services/collections.dart';
import 'package:know_waste/services/image_picker_service.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/analyzed_waste/analyzed_waste.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../providers/user_provider.dart';

final wasteAnalysisProvider = ChangeNotifierProvider.autoDispose<WasteAnalysisNotifier>(
  (ref) {
    return WasteAnalysisNotifier(ref, ref.watch(wasteRepositoryProvider));
  },
);

class WasteAnalysisNotifier extends ChangeNotifier {
  WasteAnalysisNotifier(this.ref, this.wasteRepository);

  final Ref ref;
  final AnalyzedWasteRepository wasteRepository;

  void listenToCollection() {
    StreamController<AnalyzedWaste?> controller = StreamController<AnalyzedWaste?>();
    final query = AnalyzedWasteCollection()
        .withConverter
        .where('userID', isEqualTo: ref.read(userProvider)!.uid)
        .where('name', isNotEqualTo: null)
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots(includeMetadataChanges: false)
        .listen((event) {
      for (var change in event.docChanges) {
        if (change.doc.data()!.date!.compareTo(DateTime.now().subtract(const Duration(seconds: 15))) == 1) {
          if (change.doc.data()!.name != null) {
            controller.add(change.doc.data());
          }
        }
      }
    });

    ref.onDispose(() {
      query.cancel();
      controller.close();
    });

    subscription = controller.stream.listen((data) async {
      if (data != null) {
        _fakeLoadingTimer?.cancel();
        HapticFeedback.lightImpact();
        setAnalyzedWaste(data);
        Future.delayed(const Duration(seconds: 1), () {
          setLoading(false);
          setProcessing(false);
          setLoadingProgress(0);
          setError(null);
        });
      }
    });
  }

  StreamSubscription? subscription;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  setProcessing(bool value) {
    _processing = value;
    notifyListeners();
  }

  Timer? _fakeLoadingTimer;

  Object? _error;
  Object? get error => _error;
  void setError(Object? value) {
    _error = value;
    notifyListeners();
  }

  File? _pickedImage;
  File? get pickedImage => _pickedImage;
  void setPickedImage(File? value) {
    _pickedImage = value;
    notifyListeners();
  }

  String? _pickedImageID;

  double _loadingProgress = 0;
  double get loadingProgress => _loadingProgress;
  void setLoadingProgress(double value) {
    _loadingProgress = value;
    notifyListeners();
  }

  AnalyzedWaste? _analyzedWaste;
  AnalyzedWaste? get analyzedWaste => _analyzedWaste;
  void setAnalyzedWaste(AnalyzedWaste? value) {
    _analyzedWaste = value;
    notifyListeners();
  }

  void reset() {
    _fakeLoadingTimer?.cancel();
    subscription?.cancel();
    setLoading(false);
    setAnalyzedWaste(null);
    setError(null);
    setLoadingProgress(0);
    setProcessing(false);
    setPickedImage(null);
  }

  Future<File?> pickImage({bool isCamera = false}) async {
    try {
      File? pickedImage;
      if (isCamera) {
        pickedImage = await ImagePickerService.pickImageFromCamera();
      } else {
        pickedImage = await ImagePickerService.pickImageFromGallery();
      }

      if (pickedImage != null) {
        setPickedImage(pickedImage);
        uploadImage();
      }
    } catch (e) {
      setError(e);
    }
    return pickedImage;
  }

  Future<void> uploadImage() async {
    if (pickedImage == null) {
      return;
    }
    setLoading(true);
    setError(null);

    try {
      _pickedImageID = const Uuid().v4();
      await ref.read(firebaseStorageServiceProvider).uploadImage(
            file: pickedImage!,
            path: 'items/${ref.read(userProvider)!.uid}/$_pickedImageID.jpg',
            onUploadProgress: setLoadingProgress,
          );
      setProcessing(true);
      setLoadingProgress(0);

      // Start listening to analyzed waste collection
      listenToCollection();

      // Fake loading
      _fakeLoadingTimer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
        // Set loading progress
        if (loadingProgress < 0.92) {
          setLoadingProgress(loadingProgress + 0.01 + Random().nextDouble() * 0.06);
        }
        // Set timeout
        if (timer.tick > 60) {
          setError('Something went wrong. Please try again.');
          _fakeLoadingTimer?.cancel();
          subscription?.cancel();
          setLoading(false);
          setAnalyzedWaste(null);
          setLoadingProgress(0);
          setProcessing(false);
          setPickedImage(null);
        }
      });
    } catch (e) {
      setError(e);
    }
  }

  Future<void> restart() async {
    if (analyzedWaste == null) {
      return;
    }
    final oldImageUrl = analyzedWaste!.imageUrl!;
    setLoading(true);
    setError(null);
    setAnalyzedWaste(null);

    // Delete current image from Firestore
    ref.read(firebaseStorageServiceProvider).deleteImage(oldImageUrl);

    // Reupload the image to trigger the analysis
    uploadImage();
  }

  @override
  String toString() => 'Loading: $loading, Error: $error, Analyzed Waste: $analyzedWaste, pickedImage: $pickedImage';
}
