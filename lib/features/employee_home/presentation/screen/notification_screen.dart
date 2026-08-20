import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.type = NotificationType.general,
  });
}

enum NotificationType { job, message, payment, general }

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 8.h),
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.r),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              'Notifications',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Mark all as read
            },
            child: CustomText(
              'Mark all read',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    final notifications = _getMockNotifications();

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_rounded,
              size: 64.r,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            CustomText(
              'No notifications yet',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
            SizedBox(height: 8.h),
            CustomText(
              'You\'ll see updates about your jobs\nand messages here',
              fontSize: 13.sp,
              color: AppColors.bodyTextColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final today = DateTime.now();
    final todayItems = notifications
        .where((n) => DateUtils.isSameDay(n.timestamp, today))
        .toList();
    final earlierItems = notifications
        .where((n) => !DateUtils.isSameDay(n.timestamp, today))
        .toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        if (todayItems.isNotEmpty) ...[
          SizedBox(height: 12.h),
          CustomText(
            'Today',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyTextColor,
          ),
          SizedBox(height: 8.h),
          ...todayItems.map((n) => _buildNotificationTile(n)),
        ],
        if (earlierItems.isNotEmpty) ...[
          SizedBox(height: 20.h),
          CustomText(
            'Earlier',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyTextColor,
          ),
          SizedBox(height: 8.h),
          ...earlierItems.map((n) => _buildNotificationTile(n)),
        ],
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildNotificationTile(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: notification.isRead
            ? AppColors.white
            : AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade200
              : AppColors.primary.withValues(alpha: 0.2),
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNotificationIcon(notification.type),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  notification.title,
                  fontSize: 14.sp,
                  fontWeight: notification.isRead
                      ? FontWeight.w500
                      : FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  notification.body,
                  fontSize: 12.sp,
                  color: AppColors.bodyTextColor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  _formatTimestamp(notification.timestamp),
                  fontSize: 11.sp,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8.r,
              height: 8.r,
              margin: EdgeInsets.only(left: 8.w, top: 4.h),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationType type) {
    IconData iconData;
    Color bgColor;

    switch (type) {
      case NotificationType.job:
        iconData = Icons.work_outline_rounded;
        bgColor = AppColors.primary;
        break;
      case NotificationType.message:
        iconData = Icons.chat_bubble_outline_rounded;
        bgColor = const Color(0xFF4CAF50);
        break;
      case NotificationType.payment:
        iconData = Icons.payments_outlined;
        bgColor = const Color(0xFF2196F3);
        break;
      case NotificationType.general:
        iconData = Icons.info_outline_rounded;
        bgColor = AppColors.grey;
        break;
    }

    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(iconData, size: 20.r, color: bgColor),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
  }

  List<NotificationItem> _getMockNotifications() {
    return [
      NotificationItem(
        id: '1',
        title: 'New Job Assigned',
        body:
            'You have been assigned a grooming job for Max on Aug 22 at 9:00 AM.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
        type: NotificationType.job,
      ),
      NotificationItem(
        id: '2',
        title: 'Message from Sarah',
        body: 'Hi! Can we reschedule the appointment to 3 PM instead?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        type: NotificationType.message,
      ),
      NotificationItem(
        id: '3',
        title: 'Payment Received',
        body: 'You received \$85.00 for the grooming service on Aug 18.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
        type: NotificationType.payment,
      ),
      NotificationItem(
        id: '4',
        title: 'Job Completed',
        body: 'Your grooming session for Bella has been marked as completed.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        type: NotificationType.job,
      ),
      NotificationItem(
        id: '5',
        title: 'Review Received',
        body:
            'Michael left a 5-star review: "Amazing service, will book again!"',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        type: NotificationType.general,
      ),
    ];
  }
}
