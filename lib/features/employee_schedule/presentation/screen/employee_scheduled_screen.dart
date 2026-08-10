import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../employee_home/presentation/widget/job_tile.dart';
import '../../controller/scheduled_controller.dart';


class EmployeeScheduledScreen extends StatelessWidget {
  EmployeeScheduledScreen({super.key});

  final ScheduledController controller = Get.find<ScheduledController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),

            // Header Title
            CustomText(
              'Schedule',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            SizedBox(height: 16.h),

            // Segmented Toggle Switcher (Calendar vs List)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Obx(() {
                  final isCalendar = controller.selectedViewIndex.value == 0;
                  return Row(
                    children: [
                      // Calendar Tab Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeViewIndex(0),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isCalendar ? const Color(0xFFC78330) : Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Center(
                              child: CustomText(
                                'Calendar',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: isCalendar ? AppColors.white : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // List Tab Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeViewIndex(1),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: !isCalendar ? const Color(0xFFC78330) : Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Center(
                              child: CustomText(
                                'List',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: !isCalendar ? AppColors.white : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            SizedBox(height: 16.h),

            // Dynamic Content Switcher
            Expanded(
              child: Obx(() {
                if (controller.selectedViewIndex.value == 0) {
                  return _buildCalendarView();
                } else {
                  return _buildListView();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Calendar View Body
  // ---------------------------------------------------------------------------
  Widget _buildCalendarView() {
    final jobs = controller.scheduledJobs;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar Grid Card Container
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.w,
              ),
            ),
            child: Column(
              children: [
                // Month Header Title
                CustomText(
                  'August 2026',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 16.h),

                // Days of Week Header Labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                      .map(
                        (day) => SizedBox(
                      width: 32.w,
                      child: Center(
                        child: CustomText(
                          day,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
                SizedBox(height: 12.h),

                // Interactive Days Grid
                _buildCalendarGrid(),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Selected Day Subheading
          Obx(() {
            final date = controller.selectedDate.value;
            return CustomText(
              'Aug ${date.day} — ${jobs.length} Jobs',
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            );
          }),

          SizedBox(height: 12.h),

          // Job items for the selected day using ScheduledJobTile
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return JobTile(
                job: job,
                onTap: () => controller.onJobTap(job),
              );
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Full List View Body
  // ---------------------------------------------------------------------------
  Widget _buildListView() {
    final jobs = controller.scheduledJobs;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobTile(
          job: job,
          onTap: () => controller.onJobTap(job),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Helper Grid Widget for Monthly Calendar
  // ---------------------------------------------------------------------------
  Widget _buildCalendarGrid() {
    // August 2026 Grid layout offset (Starts on Saturday)
    final List<int?> days = [
      null, null, null, null, null, null, 1,
      2, 3, 4, 5, 6, 7, 8,
      9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 19, 20, 21, 22,
      23, 24, 25, 26, 27, 28, 29,
      30, 31,
    ];

    // Mock days containing active scheduled jobs
    final jobDays = [5, 11, 18, 22];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        if (day == null) return const SizedBox.shrink();

        return Obx(() {
          final isSelected = controller.selectedDate.value.day == day;
          final hasJob = jobDays.contains(day);

          return GestureDetector(
            onTap: () => controller.selectDate(DateTime(2026, 8, day)),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFC78330) : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    '$day',
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                  if (hasJob) ...[
                    SizedBox(height: 2.h),
                    Container(
                      width: 4.r,
                      height: 4.r,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.white : const Color(0xFFC78330),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        });
      },
    );
  }
}