import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    super.key,
    required this.photo,
    this.width,
    this.height,
    this.fit,
  });

  final String photo;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (photo.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: const Icon(Icons.person, color: Colors.grey),
      );
    }
    final validPhoto = photo.startsWith('http') ? photo : AppConstants.doctorDefaultPhoto;

    return CachedNetworkImage(
      imageUrl: validPhoto,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: const Icon(Icons.error, color: Colors.grey),
      ),
    );
  }
}
