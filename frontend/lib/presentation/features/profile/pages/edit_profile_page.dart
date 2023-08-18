import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:know_waste/presentation/shared/bouncing.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../shared/app_text_field.dart';
import '../../../shared/app_toast.dart';
import '../../../theme/theme.dart';
import '../providers/edit_profile_controller.dart';
import '../widgets/change_photo_sheet.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  bool isImageLoading = false;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    ref.read(editProfileControllerProvider).whenData((value) {
      nameController.text = value?.name ?? 'New Hero';
      emailController.text = value?.email ?? 'user@beaherotoday.com';
      phoneController.text = value?.phoneNumber ?? '';
      usernameController.text = value?.username ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(editProfileControllerProvider);
    final isLoading = userState is AsyncLoading;
    ref.listen(editProfileControllerProvider, (prev, next) {
      if (next is AsyncError) {
        ApiError errorValue;
        try {
          errorValue = (next.error as ApiError);
        } on TypeError {
          errorValue = ApiError(message: 'Unknown error.');
        }
        // Show error toast
        AppToast.of(context).show(
          duration: const Duration(seconds: 5),
          text: errorValue.message,
          isError: true,
        );
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [AppShadows.primary],
        ),
        child: SafeArea(
          child: AppButton.primary(
            fillColor: AppColors.primary,
            onTap: () {
              HapticFeedback.lightImpact();
              if (_formKey.currentState!.validate()) {
                ref.read(editProfileControllerProvider.notifier).updateProfile(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      username: usernameController.text,
                      onSuccess: () => AppToast.of(context).show(text: 'Profile updated!'),
                    );
              }
            },
            isLoading: isLoading,
            child: const Text('Save'),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 65),
                    AnimationConfiguration.synchronized(
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 300),
                        scale: 0.8,
                        child: Center(
                          child: SizedBox(
                            height: 160,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/dots.svg',
                                ),
                                SvgPicture.asset(
                                  'assets/images/dotted_border.svg',
                                  height: 140,
                                  width: 140,
                                ),
                                Container(
                                  height: 140,
                                  width: 140,
                                  padding: const EdgeInsets.all(10),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: isImageLoading
                                        ? const CircularProgressIndicator()
                                        : userState.value?.profilePicture != null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl: userState.value!.profilePicture!,
                                                  height: 140,
                                                  width: 140,
                                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                'assets/icons/default-avatar.svg',
                                                height: 140,
                                                width: 140,
                                              ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Bouncing(
                                    onTap: () => ChangePhotoSheet.of(context).show(
                                      hasPhoto: userState.value?.profilePicture != null,
                                      onCamera: () async {
                                        _picker
                                            .pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 15,
                                                maxWidth: 600,
                                                maxHeight: 600)
                                            .then((photo) async {
                                          if (photo != null) {
                                            setState(() => isImageLoading = true);
                                            await ref
                                                .read(editProfileControllerProvider.notifier)
                                                .updateProfilePicture(photo);
                                            setState(() => isImageLoading = false);
                                          }
                                        });
                                      },
                                      onLibrary: () async {
                                        await _picker
                                            .pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 15,
                                                maxWidth: 600,
                                                maxHeight: 600)
                                            .then((image) async {
                                          if (image != null) {
                                            setState(() => isImageLoading = true);
                                            await ref
                                                .read(editProfileControllerProvider.notifier)
                                                .updateProfilePicture(image);
                                            setState(() => isImageLoading = false);
                                          }
                                        });
                                      },
                                      onDelete: () async {
                                        setState(() => isImageLoading = true);
                                        await ref
                                            .read(editProfileControllerProvider.notifier)
                                            .updateProfilePicture(null);
                                        setState(() => isImageLoading = false);
                                      },
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          border: Border.all(color: AppColors.background, width: 3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: const Icon(Icons.camera),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: [
                          AppTextField(
                            textController: nameController,
                            label: 'Your name',
                            hintText: 'John Doe',
                            isDisabled: isLoading,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            validator: (value) {
                              return value!.isEmpty ? 'This field is required' : null;
                            },
                          ),
                          const SizedBox(height: 15),
                          AppTextField(
                            textController: emailController,
                            label: 'Email Address',
                            hintText: 'john.doe@mail.com',
                            isDisabled: isLoading,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              bool emailValid =
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!);
                              return value.isEmpty
                                  ? 'This field is required'
                                  : !emailValid
                                      ? 'Wrong email format'
                                      : null;
                            },
                          ),
                          const SizedBox(height: 15),
                          AppTextField(
                            textController: usernameController,
                            label: 'Username',
                            hintText: 'superhero',
                            isDisabled: isLoading,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.newUsername],
                            validator: (value) {
                              return (value?.isEmpty ?? true) ? 'This field is required' : null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Security options',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.blackSemiBold16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AppButton.secondary(
                            borderRadius: 12,
                            child: const Row(
                              children: [
                                Text(
                                  'Change password',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          AppButton.primary(
                            borderRadius: 12,
                            onTap: () {
                              // DeleteAccountDialog.of(context).show().then((value) {
                              //   if (value == null || !value) {
                              //     return;
                              //   }
                              //   AppDialog.of(context).loading();
                              //   ref.read(storageNotifierProvider.notifier).deleteAccount().then((value) {
                              //     AppDialog.dispose();
                              //     GoRouter.of(context).pushReplacementNamed(RouteNames.welcome);
                              //   });
                              // }),
                            },
                            child: const Row(
                              children: [
                                // AppIcons.icon(AppIcons.deleteAccount, size: 18),
                                SizedBox(width: 10),
                                Text('Delete account'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 15,
                      top: MediaQuery.of(context).padding.top + 10,
                    ),
                    color: const Color(0xffF5F6F8).withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 50),
                        Text(
                          'Edit Profile'.toUpperCase(),
                          style: AppTextStyles.blackBold18.copyWith(fontSize: 18),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 50,
                            height: 25,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 4),
                            child: const Icon(Icons.close_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
