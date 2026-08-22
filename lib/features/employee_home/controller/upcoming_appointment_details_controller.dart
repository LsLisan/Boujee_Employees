import 'package:boujee_employees/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/google_map_service.dart';
import '../../../routes/app_routes.dart';
import '../../employee_nav/employee_nav_controller.dart';
import '../model/appointment_details_model.dart';

class UpcomingAppointmentDetailsController extends GetxController {
  final Rx<AppointmentDetailsModel?> appointmentDetails =
      Rx<AppointmentDetailsModel?>(null);

  final TextEditingController notesController = TextEditingController();

  // Reactive Photo Paths
  final Rx<String?> beforePhotoPath = Rx<String?>(null);
  final Rx<String?> afterPhotoPath = Rx<String?>(null);

  GoogleMapController? mapController;
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polylines = <Polyline>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppointmentDetails();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  void loadAppointmentDetails() {
    // Simulated route coordinates
    const LatLng userLoc = LatLng(37.7450, -122.4500);
    const LatLng destLoc = LatLng(37.7550, -122.4580);

    // Initial progress steps definition matching the UI design
    final List<ProgressStepModel> initialSteps = [
      ProgressStepModel(title: 'Assigned', isCompleted: true),
      ProgressStepModel(
        title: 'Accepted',
        subtitle: 'You have accepted this job',
        isCompleted: true,
        isCurrent: true,
      ),
      ProgressStepModel(title: 'On My Way'),
      ProgressStepModel(title: 'Arrived'),
      ProgressStepModel(title: 'Checked In'),
      ProgressStepModel(title: 'Service Started'),
      ProgressStepModel(title: 'In Progress'),
      ProgressStepModel(title: 'Completed'),
    ];

    // Initial checklist items matching UI design
    final List<ChecklistItemModel> initialChecklist = [
      ChecklistItemModel(id: '1', title: 'Nail Trim', isDone: true),
      ChecklistItemModel(id: '2', title: 'Bath', isDone: true),
      ChecklistItemModel(id: '3', title: 'Dry', isDone: false),
      ChecklistItemModel(id: '4', title: 'Haircut / Style', isDone: false),
      ChecklistItemModel(id: '5', title: 'Ear / Teeth Cleaning', isDone: false),
      ChecklistItemModel(id: '6', title: 'Special Treatment', isDone: false),
      ChecklistItemModel(id: '7', title: 'Brush Out', isDone: false),
      ChecklistItemModel(id: '8', title: 'Final Inspection', isDone: false),
    ];

    appointmentDetails.value = AppointmentDetailsModel(
      startAddress: 'Chicago, USA',
      destinationAddress: 'Golden Avenue 0520 Preston Rd.',
      distance: '4KM',
      eta: '8 min',
      petName: 'Biscuit',
      clientName: 'Robert Cary',
      serviceTitle: 'Full Groom + Nail Trim',
      startLocation: userLoc,
      destinationLocation: destLoc,

      // Status & Timeline Data
      currentStatus: 'Accepted',
      statusDescription: 'You have accepted this job',
      currentStep: 2,
      totalSteps: 8,
      nextStepTitle: 'On My Way',
      progressSteps: initialSteps,

      // Checklist & Notes
      checklistItems: initialChecklist,
      completionNotes: '',
    );

    _setupMapData();
  }

  void _setupMapData() {
    final details = appointmentDetails.value;
    if (details == null) return;

    // Set Map Markers
    markers.assignAll({
      Marker(
        markerId: const MarkerId('user_origin'),
        position: details.startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: details.startAddress,
        ),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: details.destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: InfoWindow(
          title: 'Destination',
          snippet: details.destinationAddress,
        ),
      ),
    });

    // Route Polyline Points
    final List<LatLng> polylineCoordinates = [
      details.startLocation,
      const LatLng(37.7480, -122.4520),
      const LatLng(37.7510, -122.4550),
      details.destinationLocation,
    ];

    polylines.assignAll({
      GoogleMapService.createRoutePolyline(
        polylineId: 'route_path',
        points: polylineCoordinates,
        color: AppColors.primary,
      ),
    });
  }

  /// Toggle checkbox item state reactively
  void toggleChecklistItem(String itemId) {
    final details = appointmentDetails.value;
    if (details == null) return;

    final updatedChecklist = details.checklistItems.map((item) {
      if (item.id == itemId) {
        return ChecklistItemModel(
          id: item.id,
          title: item.title,
          isDone: !item.isDone,
        );
      }
      return item;
    }).toList();

    appointmentDetails.value = AppointmentDetailsModel(
      startAddress: details.startAddress,
      destinationAddress: details.destinationAddress,
      distance: details.distance,
      eta: details.eta,
      startLocation: details.startLocation,
      destinationLocation: details.destinationLocation,
      petName: details.petName,
      clientName: details.clientName,
      serviceTitle: details.serviceTitle,
      currentStatus: details.currentStatus,
      statusDescription: details.statusDescription,
      currentStep: details.currentStep,
      totalSteps: details.totalSteps,
      nextStepTitle: details.nextStepTitle,
      progressSteps: details.progressSteps,
      checklistItems: updatedChecklist,
      completionNotes: notesController.text,
    );
  }

  /// Opens Service Checklist Screen
  void onServiceChecklistTap() {
    Get.toNamed(AppRoutes.serviceChecklist);
  }

  /// Opens Upload Photo Screen
  void onUploadPhotoTap() {
    Get.toNamed(AppRoutes.uploadPhoto);
  }

  Future<void> pickBeforePhoto() async {
    final XFile? image = await _pickFromGallery();
    if (image != null) beforePhotoPath.value = image.path;
  }

  Future<void> pickAfterPhoto() async {
    final XFile? image = await _pickFromGallery();
    if (image != null) afterPhotoPath.value = image.path;
  }

  Future<XFile?> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      return await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image. Please check gallery permission.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  void onSavePhotosTap() {
    final details = appointmentDetails.value;
    if (details != null) {
      appointmentDetails.value = AppointmentDetailsModel(
        startAddress: details.startAddress,
        destinationAddress: details.destinationAddress,
        distance: details.distance,
        eta: details.eta,
        startLocation: details.startLocation,
        destinationLocation: details.destinationLocation,
        petName: details.petName,
        clientName: details.clientName,
        serviceTitle: details.serviceTitle,
        currentStatus: details.currentStatus,
        statusDescription: details.statusDescription,
        currentStep: details.currentStep,
        totalSteps: details.totalSteps,
        nextStepTitle: details.nextStepTitle,
        progressSteps: details.progressSteps,
        checklistItems: details.checklistItems,
        completionNotes: notesController.text,
      );
    }
    Get.back(); // Close upload photo screen
  }

  /// Advances the current status to the next step in the timeline
  void advanceToNextStep() {
    final details = appointmentDetails.value;
    if (details == null || details.currentStep >= details.totalSteps) return;

    final nextStepIndex =
        details.currentStep; // 0-indexed position for next step
    final currentStepsList = List<ProgressStepModel>.from(
      details.progressSteps,
    );

    // Update old active step
    final oldCurrentIndex = details.currentStep - 1;
    if (oldCurrentIndex >= 0 && oldCurrentIndex < currentStepsList.length) {
      currentStepsList[oldCurrentIndex] = ProgressStepModel(
        title: currentStepsList[oldCurrentIndex].title,
        subtitle: currentStepsList[oldCurrentIndex].subtitle,
        isCompleted: true,
        isCurrent: false,
      );
    }

    // Update new current step
    final newCurrentStep = currentStepsList[nextStepIndex];
    currentStepsList[nextStepIndex] = ProgressStepModel(
      title: newCurrentStep.title,
      subtitle: 'Status updated to ${newCurrentStep.title}',
      isCompleted: true,
      isCurrent: true,
    );

    final nextStepNumber = details.currentStep + 1;
    final String? upcomingNextTitle = (nextStepNumber < details.totalSteps)
        ? currentStepsList[nextStepNumber].title
        : null;

    // Trigger reactive state update
    appointmentDetails.value = AppointmentDetailsModel(
      startAddress: details.startAddress,
      destinationAddress: details.destinationAddress,
      distance: details.distance,
      eta: details.eta,
      startLocation: details.startLocation,
      destinationLocation: details.destinationLocation,
      petName: details.petName,
      clientName: details.clientName,
      serviceTitle: details.serviceTitle,
      currentStatus: newCurrentStep.title,
      statusDescription: 'Status updated to ${newCurrentStep.title}',
      currentStep: nextStepNumber,
      totalSteps: details.totalSteps,
      nextStepTitle: upcomingNextTitle,
      progressSteps: currentStepsList,
      checklistItems: details.checklistItems,
      completionNotes: notesController.text,
    );
  }

  void onCancelTap() {}

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void zoomIn() {
    mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  /// Displays the Job Complete Screen
  void onCompleteJobTap() {
    Get.offNamed(AppRoutes.completeAppointment);
  }

  /// Handles navigating back to the Home Screen
  void onBackToHomeTap() {
    final EmployeeNavController navController =
        Get.find<EmployeeNavController>();
    Get.toNamed(AppRoutes.employeeNavBar);
    navController.changeIndex(0);
  }
}
