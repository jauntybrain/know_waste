import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/repositories/waste_repository.dart';
import 'package:know_waste/services/collections.dart';
import 'package:know_waste/services/image_picker_service.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/analyzed_waste/analyzed_waste.dart';
import '../../../../providers/repositories_providers.dart';

final firestoreStreamProvider = StreamProvider.autoDispose<AnalyzedWaste?>((ref) async* {
  final collection = AnalyzedWasteCollection();

  StreamController<AnalyzedWaste?> controller = StreamController<AnalyzedWaste?>();
  final query = collection.withConverter
      .where('userID', isEqualTo: 'FdGe35sDg1345SFvDS')
      .where('advice', isNotEqualTo: null)
      .orderBy('date', descending: true)
      .limit(1)
      .snapshots(includeMetadataChanges: false)
      .listen((event) {
    for (var change in event.docChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          controller.add(change.doc.data());
          break;
        case DocumentChangeType.removed:
          break;
      }
    }
  }, onError: (error) {
    print('Error occurred in the Firestore stream: $error');
  });

  ref.onDispose(() {
    query.cancel();
    controller.close();
  });

  yield* controller.stream;
});

final wasteAnalysisProvider = ChangeNotifierProvider.autoDispose<WasteAnalysisNotifier>(
  (ref) {
    final collection = AnalyzedWasteCollection();
    StreamController<AnalyzedWaste?> controller = StreamController<AnalyzedWaste?>();
    final query = collection.withConverter
        .where('userID', isEqualTo: 'FdGe35sDg1345SFvDS')
        .where('name', isNotEqualTo: null)
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots(includeMetadataChanges: false)
        .listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data()!.date!.compareTo(DateTime.now().subtract(const Duration(seconds: 10))) == 1) {
              controller.add(change.doc.data());
            }
          case DocumentChangeType.modified:
            controller.add(change.doc.data());
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    });

    ref.onDispose(() {
      query.cancel();
      controller.close();
    });

    return WasteAnalysisNotifier(ref, ref.watch(wasteRepositoryProvider), controller.stream);
  },
);

class WasteAnalysisNotifier extends ChangeNotifier {
  WasteAnalysisNotifier(this.ref, this.wasteRepository, this.stream) {
    stream.listen((data) async {
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

  final Ref ref;
  final WasteRepository wasteRepository;
  final Stream<AnalyzedWaste?> stream;

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
  void setPickedImage(File value) {
    _pickedImage = value;
    notifyListeners();
  }

  String? _pickedImageID;

  double _loadingProgress = 0;
  double get loadingProgress => _loadingProgress;
  void setLoadingProgress(double value) {
    _loadingProgress = value;
    print('setting value to: $value');
    notifyListeners();
  }

  AnalyzedWaste? _analyzedWaste;
  AnalyzedWaste? get analyzedWaste => _analyzedWaste;
  void setAnalyzedWaste(AnalyzedWaste? value) {
    _analyzedWaste = value;
    notifyListeners();
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
            path: 'items/FdGe35sDg1345SFvDS/$_pickedImageID.jpg',
            onUploadProgress: setLoadingProgress,
          );
      setProcessing(true);
      setLoadingProgress(0);

      // Fake loading
      _fakeLoadingTimer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
        if (loadingProgress < 0.98) {
          setLoadingProgress(loadingProgress + 0.01 + Random().nextDouble() * 0.06);
        }
      });
    } catch (e) {
      setError(e);
    }
  }

  @override
  String toString() {
    // todo
    return 'Loading: $loading, ';
  }
}
