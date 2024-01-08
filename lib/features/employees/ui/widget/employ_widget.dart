import 'package:al_khabeer/core/api_manager/api_service.dart';
import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/emploees_response.dart';

class EmployWidget extends StatelessWidget {
  const EmployWidget({super.key, required this.data});

  final EmployData data;

  @override
  Widget build(BuildContext context) {
    loggerObject.w(MediaQuery.of(context).textScaleFactor);
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(vertical: 10.0).h,
      withSideRed: true,
      child: Column(
        children: [
          20.0.verticalSpace,
          CircleImageWidget(
            url: Assets.iconsLogoWithoutText,
            size: 100.0.r,
          ),
          DrawableText(
            fontFamily: FontManager.cairoBold.name,
            size: 24.0.r,
            text: data.name,
            color: AppColorManager.textColor1,
          ),
          const Divider(endIndent: 0.0),
          DrawableText(
            color: AppColorManager.mainColorDark,
            size: 18.0.sp,
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).certificateOrSpecialization,
            drawableEnd: DrawableText(
              size: 20.0.sp,
              text: data.certificateName,
            ),
          ),
          DrawableText(
            color: AppColorManager.mainColorDark,
            size: 18.0.sp,
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).administrativePosition,
            drawableEnd: DrawableText(
              size: 20.0.sp,
              text: data.epithet,
            ),
          ),
          DrawableText(
            color: AppColorManager.mainColorDark,
            size: 18.0.sp,
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).salaryType,
            drawableEnd: DrawableText(
              size: 20.0.sp,
              text: data.salaryType,
            ),
          ),
          DrawableText(
            color: AppColorManager.mainColorDark,
            size: 18.0.sp,
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).employmentDate,
            drawableEnd: DrawableText(
              size: 20.0.sp,
              text: data.dateEmployment?.formatDate ?? '-',
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
