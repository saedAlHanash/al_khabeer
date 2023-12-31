import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/features/notifications/data/response/notifications_response.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';


class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.not});

  final NotificationModel not;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 21.0).h,
      padding: const EdgeInsets.symmetric( horizontal: 30.0).r,
      child: Row(
        children: [
          ImageMultiType(
            url: Assets.iconsLogoWithoutText,
            height: 30.0.r,
            width: 30.0.r,
          ),
          20.0.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                DrawableText(
                  text: not.message,
                  color: AppColorManager.mainColorDark,
                  matchParent: true,
                  size: 16.0.sp,
                  textAlign: TextAlign.start,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: not.createdAt?.formatDateTime??'',
                  matchParent: true,
                  color: AppColorManager.mainColorDark,
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
          ),
        ],
      ),
    );
  }
}
