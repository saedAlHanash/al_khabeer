import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/features/filter_data/bloc/material_cubit/material_cubit.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/date_picker_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../filter_data/bloc/group_cubit/group_cubit.dart';
import '../../bloc/inventory_cubit/inventory_cubit.dart';
import '../../data/request/inventory_request.dart';

class InventoryListPage extends StatefulWidget {
  const InventoryListPage({super.key, required this.state});

  final InventoryInitial state;

  @override
  State<InventoryListPage> createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  late final GroupCubit groupCubit;

  @override
  void initState() {
    groupCubit = context.read<GroupCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: AppColorManager.appBarColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 19.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawableText(
              text: S.of(context).totalSubjects,
              color: AppColorManager.newsHeader,
              matchParent: true,
              drawableAlin: DrawableAlin.between,
              size: 16.0.sp,
              drawableEnd: DrawableText(
                text: S.of(context).quantities,
                color: AppColorManager.newsHeader,
                size: 16.0.sp,
              ),
            ),
            DrawableText(
              text: '      ${widget.state.result.length}   ',
              fontFamily: FontManager.cairoBold.name,
              size: 20.0,
              matchParent: true,
              drawableAlin: DrawableAlin.between,
              color: AppColorManager.newsHeader,
              drawableEnd: DrawableText(
                text: widget.state.getQuantity.formatPrice,
                fontFamily: FontManager.cairoBold.name,
                color: AppColorManager.newsHeader,
                size: 20.0,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBarWidget(
        titleText: S.of(context).inventory,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                10.0.verticalSpace,
                Container(
                  color: AppColorManager.appBarColor,
                  padding: const EdgeInsets.all(20.0).r,
                  child: DrawableText(
                    text: groupCubit.state.getNameByGuid(
                      widget.state.request.groupGuid ?? '',
                    ),
                    matchParent: true,
                  ),
                ),
                10.0.verticalSpace,
                SaedTableWidget1(
                  title: [
                    S.of(context).subjectName,
                    S.of(context).unit,
                    S.of(context).quantity,
                  ],
                  data: widget.state.result.mapIndexed((i, e) {
                    return [e.materialName, e.unit, e.quantity];
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
