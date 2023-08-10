import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
    Key? key,
    this.margin,
    this.padding,
    this.cardColor = AppColorManager.cardColor,
    required this.child,
    this.elevation = 2,
    this.radios,
    this.withSideRed,
    this.shadowColor,
    this.sideColor = AppColorManager.mainColor,
  }) : super(key: key);

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color cardColor;
  final Color sideColor;
  final Widget child;
  final double elevation;
  final double? radios;
  final bool? withSideRed;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    var innerPadding = padding ?? MyStyle.cardPadding;

    //محتوى البطاقة
    final cardChild = Padding(padding: innerPadding, child: child);

    return Card(
      margin: margin,
      color: cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      shadowColor: shadowColor ?? AppColorManager.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radios ?? MyStyle.cardRadios),
      ),
      child: (withSideRed ?? false)
          ? ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: sideColor,
                      width: 50.w,
                    ),
                  ),
                ),
                child: cardChild,
              ),
            )
          : cardChild,
    );
  }
}
