import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/style_atom.dart';
import '../../../../core/utils/image_assets.dart';
import '../../../../core/widgets/blurred_blob.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/onboarding_page.dart';

/// Hosts the swipeable onboarding pages and the fixed navigation controls.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _totalPages = 3;
  static const int _lastPage = _totalPages - 1;

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    if (!_pageController.hasClients) return;
    if (_pageController.page?.round() == page) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted(int page) {
    if (page == _lastPage) {
      context.go(AppRouter.chooseRole);
    } else {
      _animateToPage(page + 1);
    }
  }

  String _illustrationFor(int index) => switch (index) {
    0 => ImageAssets.onboarding1,
    1 => ImageAssets.onboarding2,
    _ => ImageAssets.onboarding3,
  };

  String _titleFor(int index) => switch (index) {
    0 => context.t.onboarding.title1,
    1 => context.t.onboarding.title2,
    _ => context.t.onboarding.title3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundBlobs(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _totalPages,
                    onPageChanged: (index) => _currentPage.value = index,
                    itemBuilder: (context, index) => OnboardingPage(
                      illustration: _illustrationFor(index),
                      title: _titleFor(index),
                      isGradientOnRight: index == 1,
                    ),
                  ),
                ),
                SizedBox(height: 52.h),
                ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (context, page, _) => _OnboardingControls(
                    isLast: page == _lastPage,
                    onGetStarted: () => _onGetStarted(page),
                    onSkip: () => _animateToPage(_lastPage),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The fixed Get Started / Next button and Skip link shared across pages.
class _OnboardingControls extends StatelessWidget {
  const _OnboardingControls({
    required this.isLast,
    required this.onGetStarted,
    required this.onSkip,
  });

  final bool isLast;
  final VoidCallback onGetStarted;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 38.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: isLast
                ? context.t.onboarding.getStarted
                : context.t.onboarding.next,
            onTap: onGetStarted,
            borderRadius: 10,
            labelStyle: StyleAtom.onboardingButton,
          ),
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: onSkip,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Text(
                context.t.onboarding.skip,
                style: StyleAtom.onboardingSkip,
              ),
            ),
          ),
          SizedBox(height: 43.h),
        ],
      ),
    );
  }
}
