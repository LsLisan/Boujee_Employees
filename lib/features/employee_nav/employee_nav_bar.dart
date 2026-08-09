import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/global/custom_text.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/icon_path/icon_path.dart';
import 'employee_nav_controller.dart';

class EmployeeNavBar extends StatelessWidget {
  EmployeeNavBar({super.key});

  final EmployeeNavController navIndexController = Get.put(
    EmployeeNavController(),
  );

  // Add your screen widgets here corresponding to each tab index [0 - 4]
  final List<Widget> screens = [

  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: IndexedStack(
          index: navIndexController.selectedIndex.value,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20.r,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.w,
                vertical: 10.0.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    label: "Home".tr,
                    svgPath: IconPath.home,
                    activeSvgPath: IconPath.activeHome,
                  ),
                  _buildNavItem(
                    index: 1,
                    label: "My Booking".tr,
                    svgPath: IconPath.document,
                    activeSvgPath: IconPath.activeDocument,
                  ),
                  _buildNavItem(
                    index: 2,
                    label: "Pet".tr,
                    svgPath: IconPath.pawPrint,
                    activeSvgPath: IconPath.activePawPrint,
                  ),
                  _buildNavItem(
                    index: 3,
                    label: "Message".tr,
                    svgPath: IconPath.chat,
                    activeSvgPath: IconPath.activeChat,
                  ),
                  _buildNavItem(
                    index: 4,
                    label: "Profile".tr,
                    svgPath: IconPath.userProfile,
                    activeSvgPath: IconPath.activeUserProfile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String svgPath,
    required String activeSvgPath,
  }) {
    final bool isSelected = navIndexController.selectedIndex.value == index;
    final Color activeColor = AppColors.primary;
    final Color inactiveColor = AppColors.bodyTextColor;

    return Expanded(
      child: InkWell(
        onTap: () => navIndexController.changeIndex(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? activeSvgPath : svgPath,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(height: 6.h),
            CustomText(
              label,
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? activeColor : inactiveColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}