import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/services/image_upload_service.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import 'patient_edit_profile_state.dart';

@injectable
class PatientEditProfileCubit extends Cubit<PatientEditProfileState> {
  PatientEditProfileCubit(this._imageUploadService) : super(const PatientEditProfileState());

  final ImageUploadService _imageUploadService;

  Future<void> submit({
    required UserCubit userCubit,
    required String name,
    required String contactNumber,
    File? newImageFile,
  }) async {
    final currentProfile = userCubit.state.profile;
    if (currentProfile == null) return;

    emit(state.copyWith(
        status: PatientEditProfileStatus.submitting, errorMessage: null));

    try {
      String? finalPhotoUrl = currentProfile.imageUrl;
      if (newImageFile != null) {
        finalPhotoUrl = await _imageUploadService.uploadImage(newImageFile);
      }

      final updatedProfile = currentProfile.copyWith(
        name: name,
        contactNumber: contactNumber,
        imageUrl: finalPhotoUrl,
      );

      await userCubit.updateProfile(updatedProfile);

      emit(state.copyWith(status: PatientEditProfileStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: PatientEditProfileStatus.failure,
          errorMessage: mapError(e),
        ),
      );
    }
  }
}
