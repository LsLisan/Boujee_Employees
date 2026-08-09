import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/global/custom_button.dart';
import '../../../../../../core/global/custom_text.dart';
import '../../../../../../core/global/custom_text_field.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/icon_path/icon_path.dart';
import '../../../../../../routes/app_routes.dart';
import '../../../../core/global/custom_back_button.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Back Button
              const CustomBackButton(),

              SizedBox(height: 24.h),

              // 2. Header Titles
              CustomText(
                "Hey! Welcome back",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),

              SizedBox(height: 6.h),

              CustomText(
                "Sign In to your account",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyTextColor,
              ),

              SizedBox(height: 32.h),

              // 3. Email Input
              CustomTextField(
                controller: controller.emailController,
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: const Color(0xFF9CA3AF),
                  size: 20.r,
                ),
                keyboardType: TextInputType.emailAddress,
                borderRadius: 28.r,
              ),

              SizedBox(height: 16.h),

              // 4. Password Input (uses CustomTextField's built-in isPassword parameter)
              CustomTextField(
                controller: controller.passwordController,
                hintText: "Password",
                isPassword: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: const Color(0xFF9CA3AF),
                  size: 20.r,
                ),
                borderRadius: 28.r,
              ),

              SizedBox(height: 12.h),

              // 5. Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgetPassword);
                  },
                  child: CustomText(
                    "Forgot Password?",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: 28.h),

              // 6. Sign In Button
              CustomButton(
                text: "Sign In",
                onTap: controller.onSignIn,
                backgroundColor: AppColors.primary,
                borderRadius: 28.r,
                height: 52.h,
              ),

              SizedBox(height: 32.h),

              // 7. Divider "Or login with"
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomText(
                      "Or login with",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyTextColor,
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                ],
              ),

              SizedBox(height: 24.h),

              // 8. Continue with Google Button
              OutlinedButton(
                onPressed: controller.onGoogleSignIn,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 52.h),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  backgroundColor: AppColors.white,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconPath.google,
                      width: 20.r,
                      height: 20.r,
                    ),
                    SizedBox(width: 10.w),
                    CustomText(
                      "Continue with Google",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}