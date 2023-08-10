import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../students/ui/pages/students_page.dart';

class ExamTablePage extends StatelessWidget {
  const ExamTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'جدول الامتحانات',
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.0.verticalSpace,
            SpinnerWidget(items: stageSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            SpinnerWidget(items: classSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            MyButton(
              text: 'معاينة',
              width: 240.0.w,
            ),     10.0.verticalSpace,
            SaedTableWidget(
              title: [
                'تاريخ',
                'يوم',
                'فترة الامتحان',
                'نوع الامتحان',
                'اسم المادة',
              ],
              data: [
                [
                  '01/jun',
                  'السبت',
                  'شهري',
                  'شفوي',
                  'عربي',
                ],
                [
                  '01/jun',
                  'أحد',
                  'يومي',
                  'كتابي',
                  'رياضيات',
                ],
                [
                  '01/jun',
                  'إثنين',
                  'شهري',
                  'تحريري',
                  'علوم',
                ],
                [
                  '01/jun',
                  'ثلاثاء',
                  'اسبوعي',
                  'شفوي',
                  'قراءة',
                ],

              ],
            ),
          ],
        ),
      ),
    );
  }
}

final tempSpinnerItems = [
  SpinnerItem(id: 1, name: 'saed1 test'),
  SpinnerItem(id: 2, name: 'saed2 test'),
  SpinnerItem(id: 3, name: 'saed3 test'),
];
