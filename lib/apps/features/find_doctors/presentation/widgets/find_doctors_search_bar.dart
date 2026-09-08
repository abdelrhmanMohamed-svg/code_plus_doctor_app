import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../login/presentation/widgets/auth_text_field.dart';

/// Search input shown above the doctors list.
class FindDoctorsSearchBar extends StatefulWidget {
  const FindDoctorsSearchBar({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  State<FindDoctorsSearchBar> createState() => _FindDoctorsSearchBarState();
}

class _FindDoctorsSearchBarState extends State<FindDoctorsSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20.r, color: AppColors.grey),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomTextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              textAlignVertical: TextAlignVertical.center,
              style: context.regular19Grey,
              cursorColor: AppColors.grey,
              hint: context.t.findDoctors.searchHint,
              hintStyle: context.regular19Grey,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Icon(Icons.tune, size: 11.r, color: AppColors.grey),
        ],
      ),
    );
  }
}
