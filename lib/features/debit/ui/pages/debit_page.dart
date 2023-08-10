import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/features/cash_account/ui/pages/cash_account_page.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';

class DebitPage extends StatelessWidget {
  const DebitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'صافي المصاريف'),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinnerWidget(items: accountsSpinnerItems, width: .9.sw),
            10.0.verticalSpace,

            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'اسم الحساب',
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
