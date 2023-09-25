import 'package:al_khabeer/core/util/my_style.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/bloc/loading_cubit.dart';
import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.titleText,
    this.title,
    this.elevation,
    this.action,
    this.zeroHeight,
    this.actions,
    this.color,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final List<Widget>? action;
  final bool? zeroHeight;
  final double? elevation;
  final Color? color;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => context.read<LoadingCubit>().isLoadingForPop(),
      child: AppBar(
        backgroundColor: color ?? const Color(0xFFE2EEF6),
        toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
        title: title ?? DrawableText(
                text: titleText ?? '',
                size: 24.0.spMin,
                color: color != null ? Colors.white : AppColorManager.mainColor,
                fontFamily: FontManager.cairoBold,
              ),
        leading: Navigator.canPop(context) ? const BackBtnWidget() : null,
        actions: actions,
        elevation: elevation ?? 0.0,
        shadowColor: AppColorManager.black.withOpacity(0.28),
        iconTheme: const IconThemeData(color: AppColorManager.mainColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 80.0.h);
}
