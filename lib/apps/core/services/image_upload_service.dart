import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:injectable/injectable.dart';

import '../utils/app_constants.dart';

@lazySingleton
class ImageUploadService {
  ImageUploadService()
      : _cloudinary = CloudinaryPublic(
          AppConstants.cloudinaryCloudName,
          AppConstants.cloudinaryUploadPreset,
          cache: false,
        );

  final CloudinaryPublic _cloudinary;

  Future<String> uploadImage(File imageFile) async {
    final response = await _cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        imageFile.path,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    return response.secureUrl;
  }
}
