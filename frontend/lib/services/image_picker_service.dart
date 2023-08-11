import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> _pickImage({
    required ImageSource imageSource,
  }) async {
    try {
      final ImagePicker imagePicker = ImagePicker();

      final pickedFile = await imagePicker.pickImage(source: imageSource, imageQuality: 5);
      final file = pickedFile != null ? File(pickedFile.path) : null;
      return file;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> pickImageFromGallery() async {
    return await _pickImage(imageSource: ImageSource.gallery);
  }

  static Future<File?> pickImageFromCamera() async {
    return await _pickImage(imageSource: ImageSource.camera);
  }
}
