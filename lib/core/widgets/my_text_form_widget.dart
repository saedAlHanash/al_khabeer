import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget({
    Key? key,
    this.liable = '',
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.icon,
  }) : super(key: key);

  final String liable;
  final String hint;
  final String? icon;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;

  @override
  Widget build(BuildContext context) {
    final padding = innerPadding ?? EdgeInsets.symmetric(horizontal: 10.0.w);

    bool obscureText = this.obscureText;
    late Widget? suffixIcon;
    late VoidCallback onChangeObscure;

    if (icon != null) {
      suffixIcon = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: ImageMultiType(url: icon!, height: 23.0.h, width: 40.0.w),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              onChangeObscure();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: InputBorder.none,
      counter: null,
      alignLabelWithHint: true,
      labelText: liable,
      suffixIcon: suffixIcon ?? const SizedBox(),
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 16.0.spMin,
      color: AppColorManager.gray,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return TextFormField(
        decoration: inputDecoration,
        maxLines: maxLines,
        obscureText: obscureText,
        textAlign: textAlign,
        onChanged: onChanged,
        style: textStyle,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyBordType,
      );
    });
  }
}

class MyTextFormOutLineWidget extends StatelessWidget {
  const MyTextFormOutLineWidget({
    Key? key,
    this.label = '',
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color,
    this.initialValue,
    this.textDirection,
  }) : super(key: key);
  final bool? enable;
  final String label;
  final String hint;
  final String? icon;
  final Color? color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final padding = innerPadding ?? const EdgeInsets.symmetric(horizontal: 20.0).w;

    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (icon != null) {
      suffixIcon = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: SvgPicture.asset(icon!, height: 23.0.h, width: 40.0.w),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ));
      });
    }
    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(30.0.r));

    final focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? AppColorManager.mainColorDark,
          width: 2.0.spMin,
        ),
        borderRadius: BorderRadius.circular(30.0.r));

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: InputBorder.none,
      border: border,
      focusedBorder: focusedBorder,
      enabledBorder: border,
      fillColor: AppColorManager.textFieldColor,
      filled: true,
      label: DrawableText(
        text: label,
        color: AppColorManager.gray,
        size: 16.0.spMin,
      ),
      counter: const SizedBox(),
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: color ?? AppColorManager.mainColor),
      suffixIcon: suffixIcon,
      enabled: enable ?? true,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 16.0.spMin,
      color: AppColorManager.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0).h,
        child: TextFormField(
          decoration: inputDecoration,
          maxLines: maxLines,
          initialValue: initialValue,
          obscureText: obscureText,
          textAlign: textAlign,
          onChanged: onChanged,
          style: textStyle,
          textDirection: textDirection,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyBordType,
        ),
      );
    });
  }
}

class MyEditTextWidget extends StatelessWidget {
  const MyEditTextWidget({
    Key? key,
    this.hint = '',
    this.maxLines = 1,
    this.textAlign,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.backgroundColor,
    this.focusNode,
    this.obscureText = false,
    this.icon,
    this.enable,
    this.radios,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String hint;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final bool? enable;
  final TextAlign? textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final Color? backgroundColor;
  final Widget? icon;
  final FocusNode? focusNode;
  final double? radios;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    late VoidCallback onChangeObscure;

    if (icon != null) suffixIcon = icon;

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              state(() => obscureText = !obscureText);
              onChangeObscure();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                size: 20.0.spMin,
              ),
            ));
      });
    }

    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: backgroundColor ?? AppColorManager.offWhit.withOpacity(0.27),
        ),
        borderRadius: BorderRadius.circular(radios ?? 10.0.r));

    final inputDecoration = InputDecoration(
      hintText: hint,
      hintStyle: MyStyle.hintStyle,
      contentPadding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0).w,
      counter: const SizedBox(),
      enabledBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      constraints: BoxConstraints(maxWidth: .9.sw, minWidth: .3.sw),
      border: border,
      fillColor: backgroundColor ?? AppColorManager.offWhit.withOpacity(0.27),
      filled: true,
      enabled: enable ?? true,
      prefixIcon: suffixIcon ?? 0.0.verticalSpace,
      prefixIconConstraints: BoxConstraints(maxWidth: 80.0.spMin, minHeight: 50.0.spMin),
    );

    return StatefulBuilder(
      builder: (context, state) {
        onChangeObscure = () => state(() {});
        return TextFormField(
          onTap: () {
            if (controller != null) {
              if (controller!.selection ==
                  TextSelection.fromPosition(
                      TextPosition(offset: controller!.text.length - 1))) {
                state(() {
                  controller!.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller!.text.length));
                });
              }
            }
          },
          obscureText: obscureText,
          decoration: inputDecoration,
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          style: MyStyle.textFormTextStyle,
          focusNode: focusNode,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyBordType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}

class MyTextFormNoLabelWidget extends StatelessWidget {
  const MyTextFormNoLabelWidget({
    Key? key,
    this.label = '',
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color,
    this.initialValue,
    this.textDirection,
    this.iconWidget,
    this.disableAndKeepIcon,
  }) : super(key: key);
  final bool? enable;
  final bool? disableAndKeepIcon;
  final String label;
  final String hint;
  final String? icon;
  final Widget? iconWidget;
  final Color? color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final padding = innerPadding ?? EdgeInsets.symmetric(horizontal: 10.0.w);

    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (iconWidget != null) {
      suffixIcon = iconWidget;
    } else if (icon != null) {
      suffixIcon = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: ImageMultiType(url: icon!, height: 23.0.h, width: 40.0.w),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }
    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? AppColorManager.gray.withOpacity(0.7),
        ),
        borderRadius: BorderRadius.circular(10.0.r));

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: InputBorder.none,
      border: border,
      focusedErrorBorder: border,
      focusedBorder: border,
      enabledBorder: border,
      counter: const SizedBox(),
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 19.0.sp,
        color: AppColorManager.mainColorDark,
        fontFamily: FontManager.cairo.name,
      ),
      labelStyle: TextStyle(
        color: color ?? AppColorManager.mainColor,
        fontFamily: FontManager.cairo.name,
      ),
      suffixIcon: suffixIcon,
      enabled: enable ?? true,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 20.0.sp,
      color: AppColorManager.selectedIconColor,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Column(
        children: [
          if (label.isNotEmpty)
            DrawableText(
              text: label,
              matchParent: true,
              color: AppColorManager.black,
              padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
              size: 14.0.sp,
            ),
          if (label.isNotEmpty) 3.0.verticalSpace,
          TextFormField(
            decoration: inputDecoration,
            focusNode: (disableAndKeepIcon ?? false) ? AlwaysDisabledFocusNode() : null,
            maxLines: maxLines,
            initialValue: initialValue,
            obscureText: obscureText,
            textAlign: textAlign,
            onChanged: onChanged,
            style: textStyle,
            textDirection: textDirection,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyBordType,
          ),
          5.0.verticalSpace,
        ],
      );
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
