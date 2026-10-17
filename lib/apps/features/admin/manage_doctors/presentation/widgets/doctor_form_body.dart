import 'dart:io';

import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../../core/extensions/snackbar_context.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/utils/specialty_options.dart';
import '../../../../../core/widgets/confirmation_dialog.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../controller/manage_doctors_cubit.dart';
import '../controller/manage_doctors_state.dart';
import 'doctor_field_label.dart';
import 'doctor_name_field.dart';
import 'doctor_photo_picker.dart';
import 'doctor_price_field.dart';
import 'doctor_specialty_dropdown.dart';
import 'doctor_status_switch.dart';

class DoctorFormBody extends StatefulWidget {
  const DoctorFormBody({super.key, required this.doctor});

  /// When provided the form operates in edit mode and prefills the fields.
  final Doctor? doctor;

  @override
  State<DoctorFormBody> createState() => _DoctorFormBodyState();
}

class _DoctorFormBodyState extends State<DoctorFormBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedSpecialty;
  bool _isActive = true;
  File? _selectedFile;

  bool get _isEditing => widget.doctor != null;

  @override
  void initState() {
    super.initState();
    final doctor = widget.doctor;
    if (doctor != null) {
      _nameController.text = doctor.name;
      _selectedSpecialty = doctor.specialty;
      _priceController.text = doctor.price;
      _isActive = doctor.isActive;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            DoctorPhotoPicker(
              initialPhotoUrl: widget.doctor?.photo,
              onPhotoSelected: (file) => setState(() => _selectedFile = file),
            ),
            SizedBox(height: 24.h),
            DoctorFormFieldLabel(label: t.createDoctor.nameLabel),
            SizedBox(height: 8.h),
            DoctorNameField(
              controller: _nameController,
              hint: t.createDoctor.nameHint,
            ),
            SizedBox(height: 20.h),
            DoctorFormFieldLabel(label: t.createDoctor.specialtyLabel),
            SizedBox(height: 8.h),
            DoctorSpecialtyDropdown(
              selected: _selectedSpecialty,
              onChanged: (value) {
                setState(() => _selectedSpecialty = value);
              },
              items: specialtyOptions(t),
            ),
            SizedBox(height: 20.h),
            DoctorFormFieldLabel(label: t.createDoctor.priceLabel),
            SizedBox(height: 8.h),
            DoctorPriceField(
              controller: _priceController,
              hint: t.createDoctor.priceHint,
            ),
            if (_isEditing) ...[
              SizedBox(height: 20.h),
              DoctorStatusSwitch(
                isActive: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
              ),
            ],
            SizedBox(height: 32.h),
            _SubmitDoctorButton(isEditing: _isEditing, onSubmit: _submit),
            if (_isEditing) ...[
              SizedBox(height: 16.h),
              _DeleteDoctorButton(onDelete: _delete),
            ],
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final specialty = _selectedSpecialty;
    final hasPhoto = widget.doctor?.photo != null && widget.doctor!.photo.isNotEmpty;
    
    if (specialty == null || (_selectedFile == null && !hasPhoto)) {
      context.showErrorSnackBar(context.t.auth.fieldRequired);
      return;
    }
    context.read<ManageDoctorsCubit>().submit(
      id: widget.doctor?.id,
      name: _nameController.text.trim(),
      specialty: specialty,
      price: _priceController.text.trim(),
      isActive: _isActive,
      existingPhotoUrl: widget.doctor?.photo,
      newImageFile: _selectedFile,
    );
  }

  void _delete() {
    showConfirmationDialog(
      context,
      title: context.t.admin.deleteTitle,
      message: context.t.admin.deleteMessage,
      confirmLabel: context.t.admin.delete,
      cancelLabel: context.t.common.back,
      onConfirm: () {
        context.read<ManageDoctorsCubit>().deleteDoctor(widget.doctor!.id);
        context.pop();
      },
    );
  }
}

class _SubmitDoctorButton extends StatelessWidget {
  const _SubmitDoctorButton({required this.isEditing, required this.onSubmit});

  final bool isEditing;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return BlocBuilder<ManageDoctorsCubit, ManageDoctorsState>(
      buildWhen: (prev, curr) => prev.formStatus != curr.formStatus,
      builder: (context, state) {
        return PrimaryButton(
          label: isEditing
              ? t.editDoctor.submitButton
              : t.createDoctor.submitButton,
          width: double.infinity,
          height: 44,
          borderRadius: 10,
          labelStyle: context.medium14White,
          isLoading: state.formStatus == DoctorFormStatus.submitting,
          onTap: state.formStatus == DoctorFormStatus.submitting
              ? null
              : onSubmit,
        );
      },
    );
  }
}

class _DeleteDoctorButton extends StatelessWidget {
  const _DeleteDoctorButton({required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return GestureDetector(
      onTap: onDelete,
      child: Container(
        width: double.infinity,
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.red.withValues(alpha: 0.2)),
        ),
        child: Text(t.editDoctor.deleteDoctor, style: context.semiBold14Red),
      ),
    );
  }
}
