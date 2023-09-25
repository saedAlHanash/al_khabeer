import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../strings/enum_manager.dart';

class NewNav extends StatefulWidget {
  const NewNav({
    Key? key,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  final PageController controller;
  final Function(int) onChange;

  @override
  State<NewNav> createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  var selectedIndex = NavItems.home;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0.r), topLeft: Radius.circular(30.0.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0.r),
            topRight: Radius.circular(30.0.r),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColorManager.lightGray,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageMultiType(
                  url: Assets.iconsHome,
                  color: AppColorManager.gray,
                  height: 25.0.spMin,
                ),
                activeIcon: ImageMultiType(
                  url: Assets.iconsHome,
                  color: AppColorManager.mainColor,
                  height: 35.0.spMin,
                ),
                label: selectedIndex.arabicName,
              ),
              BottomNavigationBarItem(
                icon: ImageMultiType(
                  url: Assets.iconsSDolar,
                  color: AppColorManager.gray,
                  height: 25.0.spMin,
                ),
                activeIcon: ImageMultiType(
                  url: Assets.iconsSDolar,
                  color: AppColorManager.mainColor,
                  height: 35.0.spMin,
                ),
                label: selectedIndex.arabicName,
              ),
              BottomNavigationBarItem(
                icon: ImageMultiType(
                  url: Assets.iconsNotifications,
                  color: AppColorManager.gray,
                  height: 25.0.spMin,
                ),
                activeIcon: ImageMultiType(
                  url: Assets.iconsNotifications,
                  color: AppColorManager.mainColor,
                  height: 35.0.spMin,
                ),
                label: selectedIndex.arabicName,
              ),
              BottomNavigationBarItem(
                icon: ImageMultiType(
                  url: Assets.iconsAsk,
                  color: AppColorManager.gray,
                  height: 25.0.spMin,
                ),
                activeIcon: ImageMultiType(
                  url: Assets.iconsAsk,
                  color: AppColorManager.mainColor,
                  height: 35.0.spMin,
                ),
                label: selectedIndex.arabicName,
              ),
            ],
            selectedLabelStyle: TextStyle(
              color: Colors.white,
              fontFamily: FontManager.cairoSemiBold.name,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: selectedIndex.index,
            onTap: (value) {
              widget.onChange.call(value);
              setState(() => selectedIndex = NavItems.values[value]);
            },
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}
