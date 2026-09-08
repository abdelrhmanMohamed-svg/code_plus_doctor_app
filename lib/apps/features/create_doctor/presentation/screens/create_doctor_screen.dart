import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extensions/snackbar_context.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/specialty_options.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../admin/presentation/widgets/doctors_app_bar.dart';
import '../controller/create_doctor_cubit.dart';
import '../controller/create_doctor_state.dart';

class CreateDoctorScreen extends StatefulWidget {
  const CreateDoctorScreen({super.key});

  @override
  State<CreateDoctorScreen> createState() => _CreateDoctorScreenState();
}

class _CreateDoctorScreenState extends State<CreateDoctorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  String? _selectedSpecialty;
  XFile? _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _pickedImage = image);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateDoctorCubit>(
      create: (_) => getIt<CreateDoctorCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.offWhiteSoft,
        body: BlocListener<CreateDoctorCubit, CreateDoctorState>(
          listener: (context, state) {
            if (state.status == CreateDoctorStatus.success) {
              onSuccess(context);
            } else if (state.status == CreateDoctorStatus.failure) {
              context.showErrorSnackBar(context.t.createDoctor.failureMessage);
            }
          },
          child: Column(
            children: [
              DoctorsAppBar(
                title: context.t.createDoctor.title,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    size: 22.r,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        _FieldLabel(label: context.t.createDoctor.nameLabel),
                        SizedBox(height: 8.h),
                        _NameField(
                          controller: _nameController,
                          hint: context.t.createDoctor.nameHint,
                        ),
                        SizedBox(height: 20.h),
                        _FieldLabel(
                          label: context.t.createDoctor.specialtyLabel,
                        ),
                        SizedBox(height: 8.h),
                        _SpecialtyDropdown(
                          selected: _selectedSpecialty,
                          onChanged: (value) {
                            setState(() => _selectedSpecialty = value);
                          },
                          items: specialtyOptions(context.t),
                        ),
                        SizedBox(height: 20.h),
                        _FieldLabel(label: context.t.createDoctor.imageUpload),
                        SizedBox(height: 8.h),
                        _DoctorImageUploadArea(
                          imagePath: _pickedImage?.path,
                          onTap: _pickImage,
                        ),
                        SizedBox(height: 32.h),
                        _buildSubmitButton(context),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSuccess(BuildContext context) {
    context.read<CreateDoctorCubit>().reset();
    _nameController.clear();
    setState(() {
      _selectedSpecialty = null;
      _pickedImage = null;
    });
    context.showSuccessSnackBar(context.t.createDoctor.successMessage);
    context.pop(true);
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<CreateDoctorCubit, CreateDoctorState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        return PrimaryButton(
          label: context.t.createDoctor.submitButton,
          width: double.infinity,
          height: 44,
          borderRadius: 10,
          labelStyle: context.medium14White,
          isLoading: state.status == CreateDoctorStatus.submitting,
          onTap: state.status == CreateDoctorStatus.submitting
              ? null
              : () {
                  if (!_formKey.currentState!.validate()) return;
                  final specialty = _selectedSpecialty;
                  if (specialty == null) {
                    context.showErrorSnackBar(context.t.auth.fieldRequired);
                    return;
                  }
                  context.read<CreateDoctorCubit>().submit(
                    name: _nameController.text.trim(),
                    specialty: specialty,
                  );
                },
        );
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: context.medium16Dark);
  }
}

class _NameField extends StatelessWidget {
  const _NameField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return TextFormField(
      controller: controller,
      validator: AppValidator.required(t),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.regular16Black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.regular14GreyBlueDark,
        prefixIcon: Icon(
          Icons.person_outline,
          color: AppColors.greyBlueDark,
          size: 20.r,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        enabledBorder: _border(AppColors.greyBorder),
        focusedBorder: _border(AppColors.green),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder: _border(AppColors.red),
      ),
    );
  }
}

class _SpecialtyDropdown extends StatelessWidget {
  const _SpecialtyDropdown({
    required this.selected,
    required this.onChanged,
    required this.items,
  });

  final String? selected;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selected,

      onChanged: onChanged,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item, style: context.regular14Black),
            ),
          )
          .toList(),
      style: context.regular16Black,
      decoration: InputDecoration(
        hintText: context.t.createDoctor.specialtyHint,
        hintStyle: context.regular14GreyBlueDark,
        prefixIcon: Icon(
          Icons.medical_services_outlined,
          color: AppColors.greyBlueDark,
          size: 20.r,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        enabledBorder: _border(AppColors.greyBorder),
        focusedBorder: _border(AppColors.green),
      ),
    );
  }
}

class _DoctorImageUploadArea extends StatelessWidget {
  const _DoctorImageUploadArea({required this.imagePath, required this.onTap});

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 175.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyBorder, width: 1.5),
        ),
        child: imagePath == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 40.r,
                    color: AppColors.greyBlueLight,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.t.createDoctor.imageUploadHint,
                    style: context.medium14Dark,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.t.createDoctor.imageUploadTap,
                    style: context.regular12GreyBlueDark,
                  ),
                ],
              )
            : Image.file(File(imagePath!), fit: BoxFit.cover),
      ),
    );
  }
}

InputBorder _border(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(color: color, width: 1),
  );
}
