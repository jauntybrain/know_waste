import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:know_waste/models/app_user/app_user.dart';
import 'package:know_waste/providers/user_provider.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';

import '../../../../providers/repositories_providers.dart';

class EditProfileController extends AutoDisposeAsyncNotifier<AppUser?> {
  EditProfileController() : super();

  @override
  FutureOr<AppUser?> build() => ref.read(userProvider);

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String username,
    VoidCallback? onSuccess,
  }) async {
    final userRepo = ref.read(userRepositoryProvider);
    final userID = state.value?.uid;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await userRepo.updateProfile(userID!, {
        'email': email,
        'name': name,
        'phone': phone,
        'username': username,
      });
      return null;
    });

    if (state is AsyncData) {
      onSuccess?.call();
    }
  }

  Future<void> updateProfilePicture(XFile? image) async {
    final userRepo = ref.read(userRepositoryProvider);
    final userID = state.value?.uid;

    if (image == null) {
      /// Delete image
      await ref.read(firebaseStorageServiceProvider).deleteImage(state.value!.profilePicture!);
      state = AsyncData(state.value!.copyWith(profilePicture: null));
      await userRepo.updateProfile(userID!, {
        'profilePicture': null,
      });
      return;
    }

    /// Upload new image
    final file = File(image.path);
    final imageUrl = await ref.read(firebaseStorageServiceProvider).uploadImage(
          path: 'users/${ref.read(userProvider)!.uid}.jpg',
          file: file,
        );

    await userRepo.updateProfile(userID!, {'profilePicture': imageUrl});
  }

  // Future<void> changePassword({
  //   required String oldPassword,
  //   required String newPassword,
  //   VoidCallback? onSuccess,
  // }) async {
  //   final lastState = state;
  //   final authRepo = ref.read(authRepositoryProvider);
  //   state = const AsyncValue.loading();

  //   state = await AsyncValue.guard(() async {
  //     await authRepo.changePassword(
  //       oldPassword: oldPassword,
  //       newPassword: newPassword,
  //     );
  //     return lastState.value;
  //   });

  //   if (state is AsyncData) {
  //     onSuccess?.call();
  //   }
  // }
}

final editProfileControllerProvider =
    AsyncNotifierProvider.autoDispose<EditProfileController, AppUser?>(EditProfileController.new);
