import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/helper/launcher_helper.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).contact),
      body: Column(
        children: [
          0.45.sh.verticalSpace,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ItemIcon(icon: Assets.iconsGps),
              _ItemIcon(icon: Assets.iconsWeb),
              _ItemIcon(icon: Assets.iconsMail),
              _ItemIcon(icon: Assets.iconsCall),
              _ItemIcon(icon: Assets.iconsFb),
            ],
          ),
          100.0.verticalSpace,
          TextButton(
            onPressed: () {
              LauncherHelper.openPage('https://khsites.com/');
            },
            child: DrawableText(
              text: 'www.khsites.com',
              color: AppColorManager.mainColor,
              fontFamily: FontManager.cairoBold.name,
              fontWeight: FontWeight.bold,
              size: 23.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemIcon extends StatelessWidget {
  const _ItemIcon({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        switch (icon) {
          case Assets.iconsGps:
            {
              LauncherHelper.openPage('https://maps.app.goo.gl/txULQNHBJLoUL3w66');
              break;
            }
          case Assets.iconsWeb:
            {
              LauncherHelper.openPage('https://khsites.com/');
              break;
            }
          case Assets.iconsMail:
            {
              LauncherHelper.openPage('mailto:khabeer@khsites.net');
              break;
            }
          case Assets.iconsCall:
            {
              LauncherHelper.callPhone(phone: '00964 7901368724');
              break;
            }
          case Assets.iconsFb:
            {
              LauncherHelper.openPage('https://www.facebook.com/khsites');
              break;
            }
        }
      },
      icon: ImageMultiType(url: icon, height: 40.0.r, width: 40.0.r),
    );
  }
}
