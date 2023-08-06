import 'package:al_khabeer/core/util/my_style.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'جرد المخازن'),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinnerWidget(items: tempSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            SpinnerWidget(items: tempSpinnerItems, width: .9.sw),
            10.0.verticalSpace,
            MyButton(
              text: 'معاينة',
              width: 240.0.w,
            ),
            10.0.verticalSpace,
            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'group name',
                matchParent: true,
              ),
            ),
            10.0.verticalSpace,
            Expanded(
              child: SaedTableWidget1(
                title: [
                  'name',
                  'item',
                  'count',
                ],
                data: [
                  [
                    'date',
                    'day',
                    'time',
                  ],
                  [
                    'date',
                    'day',
                    'time',
                  ],
                ],
              ),
            ),
            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'group name',
                matchParent: true,
                drawableEnd: Column(
                  children: [
                    DrawableText(
                      text: 'count',
                    ),
                    DrawableText(
                      text: '3215',
                      fontFamily: FontManager.cairoBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
