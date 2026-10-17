import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import '../controller/patient_edit_profile_cubit.dart';
import '../controller/patient_edit_profile_state.dart';

class PatientEditProfileScreen extends StatelessWidget {
  const PatientEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PatientEditProfileCubit>(),
      child: const _PatientEditProfileView(),
    );
  }
}

class _PatientEditProfileView extends StatefulWidget {
  const _PatientEditProfileView();

  @override
  State<_PatientEditProfileView> createState() => _PatientEditProfileViewState();
}

class _PatientEditProfileViewState extends State<_PatientEditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _contactController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = context.read<UserCubit>().state.profile;
    _nameController = TextEditingController(text: profile?.name ?? '');
    _contactController = TextEditingController(text: profile?.contactNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
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
    context.read<PatientEditProfileCubit>().submit(
          userCubit: context.read<UserCubit>(),
          name: _nameController.text.trim(),
          contactNumber: _contactController.text.trim(),
          newImageFile: _selectedImage,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<PatientEditProfileCubit, PatientEditProfileState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == PatientEditProfileStatus.success) {
            context.showSuccessSnackBar(context.t.patientSettings.updateSuccess);
            context.pop();
          } else if (state.status == PatientEditProfileStatus.failure) {
            context.showErrorSnackBar(
                state.errorMessage ?? context.t.patientSettings.updateFailure);
          }
        },
        builder: (context, state) {
          final profile = context.read<UserCubit>().state.profile;

          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16.h, bottom: 32.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(Icons.chevron_left, color: AppColors.darkNavy, size: 24.r),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            context.t.patientSettings.profileTitle,
                            style: context.bold20White,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _ProfileImagePicker(
                      existingImageUrl: profile?.imageUrl,
                      newImageFile: _selectedImage,
                      name: profile?.name,
                      onTap: _pickImage,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.patientSettings.personalInformation,
                        style: context.bold18DarkNavy,
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        controller: _nameController,
                        hint: context.t.patientSettings.nameLabel,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _contactController,
                        hint: context.t.patientSettings.contactNumberLabel,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: PrimaryButton(
                  label: context.t.patientSettings.continueButton,
                  width: double.infinity,
                  height: 56,
                  borderRadius: 16,
                  isLoading: state.status == PatientEditProfileStatus.submitting,
                  onTap: _onSave,
                ),
              ),
            ],
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 130.r,
            height: 130.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 4),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.greenLight,
              backgroundImage: newImageFile != null
                  ? FileImage(newImageFile!)
                  : CachedNetworkImageProvider(
                      existingImageUrl ?? AppConstants.doctorDefaultPhoto)
                  as ImageProvider,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8.r, bottom: 8.r),
            padding: EdgeInsets.all(8.r),
            decoration: const BoxDecoration(
              color: AppColors.greyBlueLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.camera_alt, color: AppColors.white, size: 20.r),
          ),
        ],
      ),
    );
  }
}
