import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme.dart';

class ChangePhotoSheet {
  const ChangePhotoSheet(this.context);
  final BuildContext context;

  static ChangePhotoSheet of(BuildContext context) {
    return ChangePhotoSheet(context);
  }

  void show({hasPhoto, onCamera, onLibrary, onDelete}) {
    _showBottomSheet(context, hasPhoto, onCamera, onLibrary, onDelete);
  }

  void _showBottomSheet(context, hasPhoto, onCamera, onLibrary, onDelete) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final offset = MediaQuery.of(context).viewInsets.bottom;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: offset + (offset < 10 ? 10 : 0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 4,
                          width: 65,
                          color: const Color(0xffE8E8E8),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Update profile picture',
                        style: AppTextStyles.blackBold20,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Ready for a change? Express yourself with a new profile image.',
                        style: AppTextStyles.grayMedium16,
                      ),
                      const SizedBox(height: 20),
                      AppButton.primary(
                        onTap: () {
                          Navigator.pop(context);
                          onCamera.call();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text('Take with Camera'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppButton.primary(
                        onTap: () {
                          Navigator.pop(context);
                          onLibrary.call();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text('Pick from Library'),
                          ],
                        ),
                      ),
                      if (hasPhoto) ...[
                        const SizedBox(height: 10),
                        AppButton.secondary(
                          onTap: () {
                            Navigator.pop(context);
                            onDelete.call();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 10),
                              Text('Remove photo'),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
