import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/theme/app_colors.dart';

class DoctorPhotoPicker extends StatefulWidget {
  const DoctorPhotoPicker({
    super.key,
    required this.initialPhotoUrl,
    required this.onPhotoSelected,
  });

  final String? initialPhotoUrl;
  final ValueChanged<File?> onPhotoSelected;

  @override
  State<DoctorPhotoPicker> createState() => _DoctorPhotoPickerState();
}

class _DoctorPhotoPickerState extends State<DoctorPhotoPicker> {
  File? _selectedFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _selectedFile = file);
      widget.onPhotoSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final hasInitialPhoto = widget.initialPhotoUrl != null &&
        widget.initialPhotoUrl!.isNotEmpty &&
        !widget.initialPhotoUrl!.contains('assets/');
    final hasSelectedFile = _selectedFile != null;

    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Column(
          children: [
            Container(
              height: 100.r,
              width: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: (!hasInitialPhoto && !hasSelectedFile)
                    ? null
                    : Border.all(color: AppColors.white, width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: hasSelectedFile
                        ? Image.file(
                            _selectedFile!,
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.cover,
                          )
                        : hasInitialPhoto
                            ? CachedNetworkImage(
                                imageUrl: widget.initialPhotoUrl!,
                                width: 100.r,
                                height: 100.r,
                                fit: BoxFit.cover,
                              )
                            : _EmptyPlaceholder(),
                  ),
                  if (hasInitialPhoto || hasSelectedFile)
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.white,
                          size: 16.r,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              (hasInitialPhoto || hasSelectedFile)
                  ? t.createDoctor.changePhoto
                  : t.createDoctor.addPhoto,
              style: context.semiBold14Green,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.green.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.green.withValues(alpha: 0.5), width: 1),
      ),
      child: Center(
        child: Icon(
          Icons.camera_alt_outlined,
          color: AppColors.green,
          size: 32.r,
        ),
      ),
    );
  }
}
