import 'package:get/get.dart';
import '../../employee_home/model/job_model.dart';

class ScheduledController extends GetxController {
  // View Toggle: 0 = Calendar View, 1 = List View
  final RxInt selectedViewIndex = 0.obs;

  // Selected date in Calendar View
  final Rx<DateTime> selectedDate = DateTime(2026, 8, 5).obs;

  // List of scheduled jobs
  final RxList<JobModel> scheduledJobs = <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchScheduledJobs();
  }

  /// Switches between Calendar (0) and List (1) view modes
  void changeViewIndex(int index) {
    selectedViewIndex.value = index;
  }

  /// Updates the currently selected date in the calendar
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  /// Fetches scheduled jobs matching the design mockup
  void fetchScheduledJobs() {
    scheduledJobs.value = [
      JobModel(
        id: '1',
        petName: 'Biscuit',
        petImageUrl:
            'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Grooming pkg 26-40lbs',
        serviceCategory: 'Dog Royal Services',
        clientName: 'Robert Cary',
        time: '9:00 AM',
        duration: '90 min',
        price: 100.0,
        status: 'ACCEPTED',
        date: DateTime(2026, 8, 5),
      ),
      JobModel(
        id: '2',
        petName: 'Luna',
        petImageUrl:
            'https://images.unsplash.com/photo-1517849845537-4d257902454a?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Bath & Brush',
        serviceCategory: 'Dog Royal Services',
        clientName: 'James Park',
        time: '11:00 AM',
        duration: '120 min',
        price: 120.0,
        status: 'ASSIGNED',
        date: DateTime(2026, 8, 5),
      ),
      JobModel(
        id: '3',
        petName: 'Duke',
        petImageUrl:
            'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Deshedding Treatment',
        serviceCategory: 'Cat Royal Services',
        clientName: 'Maria Santos',
        time: '1:30 PM',
        duration: '75 min',
        price: 80.0,
        status: 'ASSIGNED',
        date: DateTime(2026, 8, 5),
      ),
      JobModel(
        id: '4',
        petName: 'Mochi',
        petImageUrl:
            'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&q=80&w=300',
        serviceTitle: 'Full Groom',
        serviceCategory: 'Dog Royal Services',
        clientName: 'Tom Anderson',
        time: '3:00 PM',
        duration: '60 min',
        price: 90.0,
        status: 'ASSIGNED',
        date: DateTime(2026, 8, 5),
      ),
    ];
  }

  /// Handles tapping a job item
  void onJobTap(JobModel job) {}
}
