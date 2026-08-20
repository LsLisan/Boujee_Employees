import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Dropdown States
  final RxString selectedRole = 'Groomer'.obs;
  final RxString selectedGender = 'Male'.obs;

  // Profile Avatar Image File Path & Network URL
  final RxString imagePath = ''.obs;
  final RxString avatarUrl =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=300'
          .obs;

  // Certificates List (Holds image paths or URLs, max 10)
  final RxList<String> certificates = <String>[].obs;

  // Options
  final List<String> roles = ['Groomer', 'Trainer', 'Veterinarian', 'Manager'];
  final List<String> genders = ['Male', 'Female', 'Other'];

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  /// Pre-fill fields with initial user & certificate data
  void _loadInitialUserData() {
    nameController.text = 'Robert Cary';
    emailController.text = 'cary08@gmail.com';
    phoneController.text = '+54898656';
    addressController.text = 'Golden Avenue 0520 Preston Rd. Ingl...';
    selectedRole.value = 'Groomer';
    selectedGender.value = 'Male';

    // Initial Certificate Mock Data
    certificates.value = [
      'https://img.freepik.com/free-vector/gradient-certificate-template_23-2148927010.jpg',
    ];
  }

  /// Change Avatar Picture Logic
  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  /// Pick new certificate image (Max 10 limit)
  Future<void> pickCertificateImage() async {
    if (certificates.length >= 10) {
      Get.snackbar(
        'Limit Reached',
        'You can only upload up to 10 certificates.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      certificates.add(image.path);
    }
  }

  /// Remove certificate by index
  void removeCertificate(int index) {
    if (index >= 0 && index < certificates.length) {
      certificates.removeAt(index);
    }
  }

  /// Save Certificates
  void saveCertificates() {
    if (certificates.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please add at least one certificate before saving.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        'Certifications saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  /// Save Profile Updates
  void saveProfile() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.back(); // Navigate back
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
