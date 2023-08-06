import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            SpinnerWidget(items: tempSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            SpinnerWidget(items: tempSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            MyButton(
              text: 'معاينة',
              width: 240.0.w,
            ),     10.0.verticalSpace,
            SaedTableWidget(
              title: [
                'date',
                'day',
                'time',
                'type',
                'name',
              ],
              data: [
                [
                  'date',
                  'day',
                  'time',
                  'type',
                  'name',
                ],
                [
                  'date',
                  'day',
                  'time',
                  'type',
                  'name',
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
