import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';

/// Section header with a title and a right-aligned "See all" link.
class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(child: Text(title, style: StyleAtom.homeSectionTitle)),
          Text(context.t.home.seeAll, style: StyleAtom.homeSeeAll),
          SizedBox(width: 4.w),
          Icon(Icons.arrow_forward_ios, size: 9.r, color: AppColors.secondary),
        ],
      ),
    );
  }
}
