import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/global/custom_back_button.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../controller/login_controller.dart';

class ForgetPasswordVerifyScreen extends StatelessWidget {
  ForgetPasswordVerifyScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // 1. Default Pin Box Style
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
    );

    // 2. Active Focused Pin Box Style
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Back Button
              const CustomBackButton(),

              SizedBox(height: 24.h),

              // 2. Title Header
              CustomText(
                "Verification Code",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 6.h),

              // 3. Subtitle Description
              CustomText(
                "Enter the verification code that we have\nsent to your email",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
                height: 1.4,
              ),

              SizedBox(height: 36.h),

              // 4. Pinput Verification Code Input
              Center(
                child: Pinput(
                  controller: controller.forgetPasswordPinController,
                  focusNode: controller.forgetPasswordPinFocusNode,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: defaultPinTheme,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  separatorBuilder: (index) => SizedBox(width: 12.w),
                  onCompleted: (pin) =>
                      controller.onVerifyForgetPasswordCode(context),
                ),
              ),

              SizedBox(height: 36.h),

              // 5. Continue Button
              CustomButton(
                text: "Continue",
                onTap: () => controller.onVerifyForgetPasswordCode(context),
                backgroundColor: AppColors.primary,
                borderRadius: 28.r,
                height: 52.h,
              ),

              SizedBox(height: 24.h),

              // 6. Resend Code Countdown Timer
              Center(
                child: Obx(
                  () => controller.secondsRemaining.value > 0
                      ? RichText(
                          text: TextSpan(
                            text: "Re-send code in ",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.bodyTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "0:${controller.secondsRemaining.value.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: controller.startResendTimer,
                          child: CustomText(
                            "Re-send code",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
