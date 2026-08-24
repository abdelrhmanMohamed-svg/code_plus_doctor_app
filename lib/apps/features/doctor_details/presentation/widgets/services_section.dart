import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

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
          style: StyleAtom.servicesTitle,
        ),
        SizedBox(height: 17.h),
        for (var i = 0; i < services.length; i++) ...[
          if (i > 0) _divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11.h),
            child: RichText(
              text: TextSpan(
                text: "${i + 1}.",
                style: StyleAtom.serviceItem.copyWith(color: AppColors.primary),
                children: [
                  TextSpan(text: services[i], style: StyleAtom.serviceItem),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _divider() {
    return Container(height: 1.h, color: AppColors.statBoxGrey);
  }
}
