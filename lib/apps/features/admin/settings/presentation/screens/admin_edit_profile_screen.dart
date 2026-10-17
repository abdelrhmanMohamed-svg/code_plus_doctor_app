import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../../../shell/presentation/widgets/admin_app_bar.dart';
import '../controller/admin_edit_profile_cubit.dart';
import '../controller/admin_edit_profile_state.dart';

class AdminEditProfileScreen extends StatelessWidget {
  const AdminEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEditProfileCubit>(),
      child: const _AdminEditProfileView(),
    );
  }
}

class _AdminEditProfileView extends StatefulWidget {
  const _AdminEditProfileView();

  @override
  State<_AdminEditProfileView> createState() => _AdminEditProfileViewState();
}

class _AdminEditProfileViewState extends State<_AdminEditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = context.read<UserCubit>().state.profile;
    _nameController = TextEditingController(text: profile?.name ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    _locationController = TextEditingController(text: profile?.clinicLocation ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _onSave() {
    context.read<AdminEditProfileCubit>().submit(
          userCubit: context.read<UserCubit>(),
          name: _nameController.text.trim(),
          clinicLocation: _locationController.text.trim(),
          newImageFile: _selectedImage,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AdminAppBar(
        title: context.t.adminSettings.editProfileTitle,
        showBackButton: true,
      ),
      body: BlocConsumer<AdminEditProfileCubit, AdminEditProfileState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AdminEditProfileStatus.success) {
            context.showSuccessSnackBar(context.t.adminSettings.updateSuccess);
            context.pop();
          } else if (state.status == AdminEditProfileStatus.failure) {
            context.showErrorSnackBar(
                state.errorMessage ?? context.t.adminSettings.updateFailure);
          }
        },
        builder: (context, state) {
          final profile = context.read<UserCubit>().state.profile;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _ProfileImagePicker(
                          existingImageUrl: profile?.imageUrl,
                          newImageFile: _selectedImage,
                          name: profile?.name,
                          onTap: _pickImage,
                        ),
                        SizedBox(height: 32.h),
                        CustomTextField(
                          controller: _nameController,
                          hint: context.t.adminSettings.fullName,
                          prefixIcon: const Icon(Icons.person_outline, color: AppColors.greyBlueDark),
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: _emailController,
                          hint: context.t.adminSettings.emailAddress,
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.greyBlueDark),
                          readOnly: true, // Email cannot be changed here
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: _locationController,
                          hint: context.t.adminSettings.clinicLocation,
                          // You can add an icon here if needed, or leave it empty
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: PrimaryButton(
                    label: context.t.adminSettings.saveChanges,
                    width: double.infinity,
                    height: 56,
                    borderRadius: 16,
                    isLoading: state.status == AdminEditProfileStatus.submitting,
                    onTap: _onSave,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  const _ProfileImagePicker({
    this.existingImageUrl,
    this.newImageFile,
    this.name,
    required this.onTap,
  });

  final String? existingImageUrl;
  final File? newImageFile;
  final String? name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: CircleAvatar(
                    backgroundColor: AppColors.greenLight,
                    backgroundImage: newImageFile != null
                        ? FileImage(newImageFile!)
                        : (existingImageUrl != null
                            ? NetworkImage(existingImageUrl!)
                            : null) as ImageProvider?,
                    child: newImageFile == null && existingImageUrl == null
                        ? Text(
                            name?.isNotEmpty == true ? name![0].toUpperCase() : '',
                            style: context.bold32Green,
                          )
                        : null,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, color: AppColors.white, size: 20.r),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, color: AppColors.green, size: 16.r),
              SizedBox(width: 8.w),
              Text(context.t.adminSettings.tapToChangePhoto, style: context.medium14Green),
            ],
          ),
        ],
      ),
    );
  }
}
