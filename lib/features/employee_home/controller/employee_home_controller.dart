import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../model/appoinemnt_model.dart';
import '../model/employee_state_model.dart';
import '../model/job_model.dart';

class EmployeeHomeController extends GetxController {
  final Rx<EmployeeStatsModel?> statsData = Rx<EmployeeStatsModel?>(null);
  final Rx<AppointmentModel?> upcomingAppointment = Rx<AppointmentModel?>(null);
  final RxList<JobModel> jobsList = <JobModel>[].obs;
  final RxBool isClockedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
    fetchUpcomingAppointment();
    fetchJobs();
  }

  void fetchStats() {
    statsData.value = EmployeeStatsModel(
      totalJobs: 4,
      completedJobs: 0,
      hoursWorked: 7.5,
      totalEarned: 186.0,
    );
  }

  void fetchUpcomingAppointment() {
    upcomingAppointment.value = AppointmentModel(
      serviceTitle: 'Grooming pkg 26-40lbs',
      petName: 'Truffle',
      clientName: 'Robert Cary',
      serviceCategory: 'Dog Royal Services',
      price: 100.0,
      time: '9:00 AM',
      duration: '90 min',
      eta: '8 min',
    );
  }

  void fetchJobs() {
    // Simulated jobs matching the design mockup
    jobsList.value = [
      JobModel(
        id: '1',
        petName: 'Truffle',
        petImageUrl:
            'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Grooming pkg 26-40lbs',
        serviceCategory: 'Dog Royal Services',
        clientName: 'Robert Cary',
        time: '9:00 AM',
        duration: '90 min',
        price: 100.0,
        status: 'ACCEPTED',
      ),
      JobModel(
        id: '2',
        petName: 'Luna',
        petImageUrl:
            'https://images.unsplash.com/photo-1517849845537-4d257902454a?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Grooming pkg 71+lbs',
        serviceCategory: 'Dog Royal Services',
        clientName: 'Robert Cary',
        time: '9:00 AM',
        duration: '120 min',
        price: 120.0,
        status: 'ASSIGNED',
      ),
      JobModel(
        id: '3',
        petName: 'Duke',
        petImageUrl:
            'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Full Grooming pkg',
        serviceCategory: 'Cat Royal Services',
        clientName: 'Maria Santos',
        time: '11:00 AM',
        duration: '75 min',
        price: 80.0,
        status: 'ASSIGNED',
      ),
    ];
  }

  void toggleClockInStatus() {
    isClockedIn.value = !isClockedIn.value;
  }

  void onViewDetailsTap() {
    Get.toNamed(AppRoutes.upcomingAppointmentDetails);
  }

  void onNavigateTap() {
    Get.toNamed(AppRoutes.upcomingAppointmentDetails);
  }

  void onViewAllJobsTap() {
    Get.toNamed(AppRoutes.allJobs);
  }

  void onJobTap(JobModel job) {}
}
