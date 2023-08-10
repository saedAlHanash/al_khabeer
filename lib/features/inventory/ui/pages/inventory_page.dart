import 'package:al_khabeer/core/extensions/extensions.dart';
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
            SpinnerWidget(items: matirialSpinnerItems, width: .9.sw),
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
                text: 'اسم المجموعة',
                matchParent: true,
              ),
            ),
            10.0.verticalSpace,
            Expanded(
              child: SaedTableWidget1(
                title: [
                  'اسم المادة',
                  'الوحدة',
                  'الكمية',
                ],
                data: [
                  [
                    'قلم',
                    'باكيت',
                    '60',
                  ],
                  [
                    'ممحاة',
                    'باكيت',
                    '60',
                  ],
                  [
                    'كراسة',
                    '',
                    '60',
                  ],
                ],
              ),
            ),
            Container(
              decoration: MyStyle.roundBox,
              padding: EdgeInsets.all(20.0).r,
              child: DrawableText(
                text: 'مجموع المواد',
                matchParent: true,
                drawableEnd: Column(
                  children: [
                    DrawableText(
                      text: 'الكميات',
                    ),
                    DrawableText(
                      text: 200000.0.formatPrice,
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
final tempSpinnerItems = [
  SpinnerItem(id: -1, name: 'اسم المجموعة'),
  SpinnerItem(id: 1, name: 'القرطاسية'),
  SpinnerItem(id: 2, name: 'مواد الفصول'),
  SpinnerItem(id: 3, name: 'المنظفات'),
];

final matirialSpinnerItems = [
  SpinnerItem(id: -1, name: 'اسم المادة'),
  SpinnerItem(id: 1, name: 'أقلام'),
  SpinnerItem(id: 2, name: 'محايات'),
  SpinnerItem(id: 3, name: 'طبشور'),
];
