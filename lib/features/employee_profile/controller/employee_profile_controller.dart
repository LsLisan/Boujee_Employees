import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../model/employee_profile_model.dart';
import '../presentation/widget/delete_logout_bottom_sheet.dart';

class EmployeeProfileController extends GetxController {
  final Rx<EmployeeProfileModel?> profileData = Rx<EmployeeProfileModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeProfile();
  }

  void fetchEmployeeProfile() {
    isLoading.value = true;

    // Simulated API response data matching UI mockup
    profileData.value = EmployeeProfileModel(
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=300',
      name: 'Robert Cary',
      email: 'cary08@gmail.com',
      badge: 'Top Groomer',
      rating: 5.0,
      jobsDone: 124,
      role: 'Groomer',
      employeeId: '#1042',
      startDate: 'March 14, 2022',
      experience: '4+ years',
      workingHours: '8:00 AM — 5:00 PM',
      certifications: [
        CertificationModel(
          title: 'National Pet Grooming Association',
          icon: '🥇',
        ),
      ],
    );

    isLoading.value = false;
  }

  void onEditProfileTap() {
    Get.toNamed(AppRoutes.editProfile);
  }

  void onCertificationsTap() {
    Get.toNamed(AppRoutes.certificate);
  }

  void onPrivacyPolicyTap() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  void onDeleteAccountTap() {
    DeleteLogoutBottomSheet.showDelete(
      onDeleteConfirm: () {
        Get.back(); // Close the bottom sheet

        Get.snackbar(
          'Account Deleted',
          'Your account has been successfully deleted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
    );
  }

  /// Handles opening the Logout confirmation bottom sheet
  void onLogoutTap() {
    DeleteLogoutBottomSheet.showLogout(
      onLogoutConfirm: () {
        Get.back(); // Close the bottom sheet

        Get.snackbar(
          'Logged Out',
          'You have been logged out successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
        );
      },
    );
  }
}
