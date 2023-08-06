
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_khabeer/core/app_theme.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';


class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  final Widget? child;
  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          selectable: false,
          color: AppColorManager.whit,
          fontFamily: FontManager.cairoBold,
          size: 16.0.sp,
        );

    return SizedBox(
      width: width??.8.sw,
      height: height ?? 47.0.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return color ?? AppColorManager.mainColor.withOpacity(0.8);

                }
                return color ?? AppColorManager.mainColor; // Use the component's default.
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) => secondaryColor.withOpacity(0.3),
            ),
            shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 15.0.r,
              ),
            ))),
        child: child,
      ),
    );
  }
}

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({
    Key? key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.width,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  final Widget? child;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? elevation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          selectable: false,
          color: textColor ?? AppColorManager.mainColor,
          fontFamily: FontManager.cairoBold,
          size: 18.0.sp,
        );

    return SizedBox(
      width: width ?? 370.0.w,
      height: 50.0.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color ?? AppColorManager.whit.withOpacity(0.1);
              }
              return color ?? AppColorManager.whit; // Use the component's default.
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) => AppColorManager.lightGray,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0.r),
              side: BorderSide(
                width: 1.0.spMin,
                color: borderColor ?? AppColorManager.mainColor,
              ),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.icon,
  }) : super(key: key);

  final Widget? child;
  final Widget? icon;
  final String text;
  final Color? color;
  final double? elevation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          selectable: false,
          color: AppColorManager.whit,
          fontFamily: FontManager.cairoBold,
          size: 16.0.sp,
        );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0).w,
      child: ElevatedButton.icon(
        onPressed: onTap,
        label: child,
        icon: icon ?? 0.0.verticalSpace,
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    this.child,
    this.width,
    this.wrapHeight = false,
    this.color,
    this.elevation,
  }) : super(key: key);
  final Widget? child;
  final double? width;
  final Color? color;
  final double? elevation;
  final bool wrapHeight;

  @override
  Widget build(BuildContext context) {
    final height = !wrapHeight ? 48.0.h : null;

    final RadialGradient? gradient;

    if (color == null) {
      gradient = const RadialGradient(colors: [
        AppColorManager.mainColorLight,
        AppColorManager.mainColor,
        AppColorManager.mainColorLight,
      ], radius: 90.0);
    } else {
      gradient = null;
    }

    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        gradient: gradient,
        color: color,
        boxShadow: [
          BoxShadow(
            color: AppColorManager.gray.withOpacity(0.4),
            offset: Offset(0, 2.0.h),
            blurRadius: elevation ?? 0,
          )
        ]);

    return Wrap(
      children: [
        Container(
          height: height,
          width: width ?? 314.0.w,
          decoration: decoration,
          child: Align(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ],
    );
  }
}
