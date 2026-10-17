import 'dart:io';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/services/image_upload_service.dart';
import '../../../../../core/utils/pref_helper.dart';
import '../../../../common/profile/presentation/controller/user_cubit.dart';
import 'admin_edit_profile_state.dart';

@injectable
class AdminEditProfileCubit extends Cubit<AdminEditProfileState> {
  AdminEditProfileCubit(
    this._imageUploadService,
  ) : super(const AdminEditProfileState());

  final ImageUploadService _imageUploadService;

  Future<void> submit({
    required UserCubit userCubit,
    required String name,
    required String clinicLocation,
    File? newImageFile,
  }) async {
    final currentProfile = userCubit.state.profile;
    if (currentProfile == null) return;

    emit(state.copyWith(
        status: AdminEditProfileStatus.submitting, errorMessage: null));

    try {
      String? finalPhotoUrl = currentProfile.imageUrl;
      if (newImageFile != null) {
        finalPhotoUrl = await _imageUploadService.uploadImage(newImageFile);
      }

      final updatedProfile = currentProfile.copyWith(
        name: name,
        clinicLocation: clinicLocation,
        imageUrl: finalPhotoUrl,
      );

      await userCubit.updateProfile(updatedProfile);
      await PrefHelper.setClinicLocation(clinicLocation);

      emit(state.copyWith(status: AdminEditProfileStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: AdminEditProfileStatus.failure,
          errorMessage: mapError(e),
        ),
      );
    }
  }
}
