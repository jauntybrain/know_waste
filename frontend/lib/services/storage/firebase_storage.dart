import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageServiceProvider = Provider<FirebaseStorageService>((_) {
  return FirebaseStorageService.instance;
});

class FirebaseStorageService {
  FirebaseStorageService._();

  static final instance = FirebaseStorageService._();

  Future<String> uploadImage({
    required File file,
    required String path,
    Function(double)? onUploadProgress,
  }) async {
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(file, SettableMetadata(contentType: 'image/jpg'));
    late String downloadUrl;

    uploadTask.snapshotEvents.listen((event) async {
      final progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      onUploadProgress?.call(progress);
    });

    final TaskSnapshot taskSnapshot = await uploadTask;

    if (taskSnapshot.state == TaskState.success) {
      downloadUrl = await storageReference.getDownloadURL();
    }

    return downloadUrl;
  }

  Future<List<String>> uploadMultipleImages({
    required List<File> images,
    required String path,
    String? fileNamePrefix,
  }) async {
    return await Future.wait(
      images.map((image) async {
        return await uploadImage(
          file: image,
          path: '$path/$fileNamePrefix-${image.uri.pathSegments.last}',
        );
      }),
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    final storageReference = FirebaseStorage.instance.ref(imagePath);
    return storageReference.getDownloadURL();
  }
}
