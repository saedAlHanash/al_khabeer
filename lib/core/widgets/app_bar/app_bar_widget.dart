import 'dart:io';

import 'package:al_khabeer/core/api_manager/api_service.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router/app_router.dart';
import '../../app/bloc/loading_cubit.dart';
import '../../injection/injection_container.dart';
import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.titleText,
    this.title,
    this.elevation,
    this.leading,
    this.action,
    this.zeroHeight,
    this.actions,
    this.color,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final bool? zeroHeight;
  final double? elevation;
  final Color? color;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? AppColorManager.appBarColor,
      toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
      title: title ??
          DrawableText(
            text: titleText ?? '',
            color: color != null ? Colors.white : AppColorManager.mainColorDark,
            size: 24.0.spMin,
            fontFamily: FontManager.cairoBold.name,
          ),
      leading: Navigator.canPop(context) ? BackBtnWidget(color: color) : leading,
      actions: actions,
      elevation: elevation ?? 0.0,
      shadowColor: AppColorManager.black.withOpacity(0.28),
      iconTheme: const IconThemeData(color: AppColorManager.textColor1),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 80.0.h);
}

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({super.key, required this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!Navigator.canPop(context)) {
          return;
        }
        Navigator.pop(context);
      },
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        color: (color != null && isColorDark(color!))
            ? AppColorManager.whit
            : AppColorManager.textColor1,
      ),
    );
  }
}
