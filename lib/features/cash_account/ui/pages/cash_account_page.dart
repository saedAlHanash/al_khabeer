import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';

class CashAccount extends StatelessWidget {
  const CashAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'حساب النقدية'),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinnerWidget(items: accountsSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            10.0.verticalSpace,
            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'اسم المجموعة',
                matchParent: true,
              ),
            ),
            10.0.verticalSpace,
            Expanded(
              child: SaedTableWidget1(
                title: [
                  'اسم الحساب',
                  'الرصيد',
                  'ملاحظات',
                ],
                data: [
                  [
                    'اسم الحساب',
                    5000.0.formatPrice,
                    '',
                  ],
                  [
                    'اسم الحساب',
                    1000.0.formatPrice,
                    '',
                  ],
                  [
                    'اسم الحساب',
                    9000.0.formatPrice,
                    'يرجى تسديد آخر دفعة',
                  ],
                ],
              ),
            ),
            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'مجموع',
                matchParent: true,
                drawableEnd: DrawableText(
                  text: 654500.formatPrice,
                  fontFamily: FontManager.cairoBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
final accountsSpinnerItems = [
  SpinnerItem(id: -1, name: 'اسم الحساب'),
  SpinnerItem(id: 1, name: 'حساب البنك'),
  SpinnerItem(id: 2, name: 'حساب بنك البركة'),
  SpinnerItem(id: 3, name: 'حساب الاتحاد'),
];
