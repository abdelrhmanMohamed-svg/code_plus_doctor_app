import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';

/// Services list section on the Doctor Details screen.
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.services});

  final List<String> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.doctorDetails.servicesTitle,
          style: context.medium18Dark,
        ),
        SizedBox(height: 17.h),
        for (var i = 0; i < services.length; i++) ...[
          if (i > 0) _divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11.h),
            child: RichText(
              text: TextSpan(
                text: "${i + 1}.",
                style: context.light13Grey.copyWith(color: AppColors.green),
                children: [
                  TextSpan(text: services[i], style: context.light13Grey),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _divider() {
    return Container(height: 1.h, color: AppColors.greyMedium);
  }
}
