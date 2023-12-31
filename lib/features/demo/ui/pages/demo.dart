import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: 'عن الديمو',
        color: AppColorManager.mainColorDark,
      ),
      backgroundColor: AppColorManager.tableTitleText,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0).r,
        child: Column(
          children: [
            ImageMultiType(
              url: Assets.iconsLogoWithoutText,
              height: 100.0.r,
              width: 100.0.r,
            ),
            10.0.verticalSpace,
            DrawableText(
              text: '',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

