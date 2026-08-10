import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../model/job_model.dart';

class JobTile extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const JobTile({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAccepted = job.status.toUpperCase() == 'ACCEPTED';

    // Status Badge colors based on design
    final Color badgeBgColor = isAccepted ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9);
    final Color badgeTextColor = isAccepted ? const Color(0xFF3B82F6) : const Color(0xFF64748B);
    final Color dotColor = isAccepted ? const Color(0xFF4CAF50) : const Color(0xFFF59E0B);

    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pet Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.network(
                  job.petImageUrl,
                  width: 60.r,
                  height: 60.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60.r,
                    height: 60.r,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.pets, color: Colors.grey, size: 28.r),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Middle Information Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pet Name + Status Dot
                    Row(
                      children: [
                        CustomText(
                          job.petName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    // Service Title & Category
                    CustomText(
                      '${job.serviceTitle} · ${job.serviceCategory}',
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),

                    // Client, Time & Duration
                    CustomText(
                      '${job.clientName} · ${job.time} · ${job.duration}',
                      fontSize: 11.sp,
                      color: Colors.grey.shade500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Right Column: Status Chip & Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: badgeBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomText(
                      job.status.toUpperCase(),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: badgeTextColor,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Price
                  CustomText(
                    '\$${job.price.toInt()}',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ],
              ),
            ],
          ),
        )
      );
    }
}