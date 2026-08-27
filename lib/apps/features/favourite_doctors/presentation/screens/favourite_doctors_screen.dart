import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../controller/favourite_doctors_cubit.dart';
import '../widgets/favourite_doctor_grid_card.dart';
import '../widgets/favourite_doctors_search_bar.dart';
import '../widgets/favourite_feature_doctor_card.dart';

/// Favourite Doctors screen replacing the Appointments tab.
class FavouriteDoctorsScreen extends StatelessWidget {
  const FavouriteDoctorsScreen({super.key});

  List<_GridDoctor> _buildGridDoctors(BuildContext context) => [
    _GridDoctor(
      id: 'dr-shouey-dentist',
      name: context.t.favouriteDoctors.drShouey,
      specialty: context.t.favouriteDoctors.specalistDentist,
      photo: ImageAssets.popularDoctor1,
    ),
    _GridDoctor(
      id: 'dr-shouey-cardiology',
      name: context.t.favouriteDoctors.drShouey,
      specialty: context.t.favouriteDoctors.specalistCardiology,
      photo: ImageAssets.popularDoctor2,
    ),
    _GridDoctor(
      id: 'dr-christenfeld-cancer',
      name: context.t.favouriteDoctors.drChristenfeldN,
      specialty: context.t.favouriteDoctors.specalistCancer,
      photo: ImageAssets.liveDoctor1,
    ),
    _GridDoctor(
      id: 'dr-shouey-medicine',
      name: context.t.favouriteDoctors.drShouey,
      specialty: context.t.favouriteDoctors.specalistMedicine,
      photo: ImageAssets.liveDoctor2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gridDoctors = _buildGridDoctors(context);
    final initialFavorites = gridDoctors.where((d) => true).map((d) => d.id);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: BlocProvider<FavouriteDoctorsCubit>(
              create: (_) =>
                  getIt<FavouriteDoctorsCubit>()
                    ..setInitialFavorites(initialFavorites),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                    child: Row(
                      children: [
                        Text(
                          context.t.favouriteDoctors.title,
                          style: StyleAtom.findDoctorsTitle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const FavouriteDoctorsSearchBar(),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle(
                            title: context.t.favouriteDoctors.title,
                          ),
                          SizedBox(height: 14.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: gridDoctors.length,
                            itemBuilder: (context, index) {
                              final doctor = gridDoctors[index];
                              return FavouriteDoctorGridCard(
                                id: doctor.id,
                                name: doctor.name,
                                specialty: doctor.specialty,
                                photo: doctor.photo,
                              );
                            },
                          ),
                          SizedBox(height: 24.h),
                          _SectionTitle(
                            title: context.t.favouriteDoctors.featureDoctor,
                          ),
                          SizedBox(height: 14.h),
                          SizedBox(
                            height: 130.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12.w),
                              itemBuilder: (context, index) {
                                final doctors = [
                                  _FeatureDoctor(
                                    context.t.doctorData.drCrick,
                                    context.t.doctorData.priceCrick,
                                    '3.7',
                                  ),
                                  _FeatureDoctor(
                                    context.t.doctorData.drStrain,
                                    context.t.doctorData.priceStrain,
                                    '3.0',
                                  ),
                                  _FeatureDoctor(
                                    context.t.doctorData.drLachinet,
                                    context.t.doctorData.priceLachinet,
                                    '2.9',
                                  ),
                                  _FeatureDoctor(
                                    context.t.doctorData.drCrick,
                                    context.t.doctorData.priceCrick,
                                    '3.0',
                                  ),
                                ];
                                final doctor = doctors[index];
                                return FavouriteFeatureDoctorCard(
                                  name: doctor.name,
                                  price: doctor.price,
                                  rating: doctor.rating,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          width: 30.r,
          height: 30.r,
          child: Icon(
            Icons.chevron_left,
            size: 18.r,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: StyleAtom.homeSectionTitle);
  }
}

class _GridDoctor {
  const _GridDoctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.photo,
  });

  final String id;
  final String name;
  final String specialty;
  final String photo;
}

class _FeatureDoctor {
  const _FeatureDoctor(this.name, this.price, this.rating);

  final String name;
  final String price;
  final String rating;
}
