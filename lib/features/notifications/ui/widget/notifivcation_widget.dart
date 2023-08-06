import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/features/notifications/data/response/notifications_response.dart';


class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.not});

  final NotificationModel not;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0).h,
      padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0).r,
      decoration: BoxDecoration(
        color: AppColorManager.f6,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(
        children: [
          DrawableText(
            text: not.message,
            matchParent: true,
            textAlign: TextAlign.start,
          ),
          10.0.verticalSpace,
          DrawableText(
            text: not.createdAt?.formatDateTime??'',
            matchParent: true,
            color: Colors.grey,
            size: 12.0.spMin,
            textAlign: TextAlign.start,
            drawablePadding: 10.0.w,
            drawableStart: Icon(
              Icons.access_time_outlined,
              color: AppColorManager.mainColor,
              size: 14.0.r,
            ),
          ),
        ],
      ),
    );
  }
}
