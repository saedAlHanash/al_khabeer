import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';

class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage({super.key, required this.studentInfo});

  final List<dynamic> studentInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'معلومات الطالب',
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.0.verticalSpace,
            SaedTableWidget(
              title: [
                'الاسم',
                'الصف',
                'الرصيد',
              ],
              data: [studentInfo],
            ),
            Container(
              width: .9.sw,
              padding: EdgeInsets.all(20.0).r,
              decoration: MyStyle.roundBox,
              child: Column(
                children: [
                  DrawableText(
                    fontFamily: FontManager.cairoBold,
                    matchParent: true,
                    text: 'مجموع مبلغ الدفعات',
                    drawableEnd: DrawableText(
                      fontFamily: FontManager.cairoBold,
                      text: 20000000.formatPrice,
                    ),
                  ),
                  DrawableText(
                    color: AppColorManager.mainColor.withOpacity(0.6),
                    matchParent: true,
                    text: '(أجر المرحله + الاضافيات)',
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    fontFamily: FontManager.cairoBold,
                    matchParent: true,
                    text: 'متبقي مبلغ الاقساط ',
                    drawableEnd: DrawableText(
                      fontFamily: FontManager.cairoBold,
                      text: 500000.formatPrice,
                    ),
                  ),
                  DrawableText(
                    color: AppColorManager.mainColor.withOpacity(0.6),
                    matchParent: true,
                    text: '(أجر المرحله + الاضافيات)',
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(child: MyStepper(list: ['', '', ''])),
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatelessWidget {
  const MyStepper({super.key, required this.list});

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).r,
      child: ListView(
        padding: EdgeInsets.only(bottom: 20.0).h,
        children: list
            .mapIndexed((i, e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawableText(
                      matchParent: true,
                      text: DateTime.now().formatDate,
                      drawableStart: Icon(
                        Icons.check_circle,
                        size: 20.0.r,
                        color: AppColorManager.mainColor,
                      ),
                      drawableEnd: DrawableText(
                        text: 30000.formatPrice,
                      ),
                    ),
                    if (i < list.length - 1)
                      Container(
                        height: 50.0.h,
                        margin: EdgeInsets.only(right: 10.0).r,
                        color: Colors.grey,
                        width: 2.0.w,
                      ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
