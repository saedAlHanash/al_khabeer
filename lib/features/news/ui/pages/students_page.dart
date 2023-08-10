import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../router/app_router.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key, this.withAppBar = true});

  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!withAppBar)
          ? null
          : const AppBarWidget(
              titleText: 'أرصدة الطلاب',
            ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.0.verticalSpace,
            SpinnerWidget(
              items: stageSpinnerItems,
              width: .9.sw,
              // hint: DrawableText(
              //   text: 'المرحلة',
              //   color: Colors.white,
              // ),
            ),
            10.0.verticalSpace,
            SpinnerWidget(items: classSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            MyButton(
              text: 'معاينة',
              width: 240.0.w,
            ),
            10.0.verticalSpace,
            SaedTableWidget(
              title: [
                'الاسم',
                'الصف',
                'الرصيد',
              ],
              data: [
                [
                  'محمد',
                  'رابع',
                  50000.formatPrice,
                ],
                [
                  'سامح',
                  'سابع',
                  3000.formatPrice,
                ],
              ],
              onTapItem: (list, i) {
                Navigator.pushNamed(context, RouteName.studentInfo, arguments: list);
                print(list);
              },
            ),
          ],
        ),
      ),
    );
  }
}

final stageSpinnerItems = [
  SpinnerItem(id: -1, name: 'المرحلة'),
  SpinnerItem(id: 1, name: 'إعدادي'),
  SpinnerItem(id: 2, name: 'ابتدائي '),
  SpinnerItem(id: 3, name: 'ثانوي'),
];

final classSpinnerItems = [
  SpinnerItem(id: -1, name: 'الصف'),
  SpinnerItem(id: 1, name: 'أول'),
  SpinnerItem(id: 2, name: 'ثاني '),
  SpinnerItem(id: 3, name: 'ثالث'),
];
