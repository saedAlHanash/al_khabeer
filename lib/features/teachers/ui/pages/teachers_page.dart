import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_card_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../generated/assets.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'ذاتية المدرسين'),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0).r,
        children: [
          for (var i = 0; i < 4; i++)
            MyCardWidget(
              margin: EdgeInsets.symmetric(vertical: 10.0).h,
              withSideRed: true,
              sideColor: AppColorManager.mainColorLight,
              child: Column(
                children: [
                  20.0.verticalSpace,
                  CircleImageWidget(
                    url: Assets.iconsLogoWithoutText,
                    size: 100.0.r,
                  ),
                  DrawableText(
                    matchParent: true,
                    textAlign: TextAlign.center,
                    drawableAlin: DrawableAlin.between,
                    text: 'اسم المدرس',
                  ),
                  Divider(endIndent: 0.0),
                  DrawableText(
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    text: 'الشهادة او الاختصاص',
                    drawableEnd: DrawableText(
                      text: 'علوم',
                    ),
                  ),
                  DrawableText(
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    text: 'الصفة الادارية',
                    drawableEnd: DrawableText(
                      text: 'مسؤول',
                    ),
                  ),
                  DrawableText(
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    text: 'نوع الراتب',
                    drawableEnd: DrawableText(
                      text: 'دينار',
                    ),
                  ),
                  DrawableText(
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    text: 'تاريخ المباشرة',
                    drawableEnd: DrawableText(
                      text: DateTime.now().formatDate,
                    ),
                  ),
                  20.0.verticalSpace,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
