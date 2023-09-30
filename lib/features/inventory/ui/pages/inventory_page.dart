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

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final request = InventoryRequest();

  late final GroupCubit groupCubit;
  late final MaterialCubit materialCubit;


  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  @override
  void initState() {
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    groupCubit = context.read<GroupCubit>();
    materialCubit = context.read<MaterialCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<InventoryCubit, InventoryInitial>(
        builder: (context, state) {
          return Container(
            height: 75.0.h,
            decoration: MyStyle.roundBox,
            padding: const EdgeInsets.all(5.0).r,
            margin: const EdgeInsets.all(15.0).r,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DrawableText(
                        text: S.of(context).totalSubjects,
                      ),
                      DrawableText(
                        text: state.result.length.formatPrice,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      DrawableText(
                        text: S.of(context).quantities,
                      ),
                      DrawableText(
                        text: state.getQuantity.formatPrice,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      appBar: AppBarWidget(
        titleText: S.of(context).inventory,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<GroupCubit, GroupInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return SpinnerWidget(
                  hint: DrawableText(text: S.of(context).group, color: Colors.white),
                  items: state.getSpinnerItems(selectedId: request.groupGuid),
                  width: .9.sw,
                  onChanged: (val) {
                    request.groupGuid = val.guid;
                    //get inventory data
                    context.read<InventoryCubit>().getInventory(
                          context,
                          request: request,
                        );

                    //get material Data
                    context.read<MaterialCubit>().getMaterials(
                          context,
                          groupGuid: val.guid,
                        );
                  },
                );
              },
            ),
            10.0.verticalSpace,
            BlocBuilder<MaterialCubit, MaterialInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return SpinnerWidget(
                  hint: DrawableText(text: S.of(context).subjectName, color: Colors.white),
                  items: state.getSpinnerItems(selectedId: request.materialGuid),
                  width: .9.sw,
                  onChanged: (val) {
                    request.materialGuid = val.guid;
                    //get inventory data
                    context.read<InventoryCubit>().getInventory(
                          context,
                          request: request,
                        );
                  },
                );
              },
            ),
            10.0.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
              child: Row(
                children: [
                  Expanded(
                    child: MyTextFormNoLabelWidget(
                      hint: 'تاريخ بداية',
                      textAlign: TextAlign.center,
                      controller: startDateC,
                      disableAndKeepIcon: true,
                      textDirection: TextDirection.ltr,
                      iconWidget: SelectSingeDateWidget(
                        initial: request.startTime,
                        onSelect: (selected) {
                          startDateC.text = selected?.formatDate ?? '';
                          request.startTime = selected;
                          context
                              .read<InventoryCubit>()
                              .getInventory(context, request: request);
                        },
                      ),
                    ),
                  ),
                  10.0.horizontalSpace,
                  Expanded(
                    child: MyTextFormNoLabelWidget(
                      hint: 'تاريخ نهاية',
                      textAlign: TextAlign.center,
                      controller: endDateC,
                      disableAndKeepIcon: true,
                      color: AppColorManager.mainColorLight.withOpacity(0.5),
                      textDirection: TextDirection.ltr,
                      iconWidget: SelectSingeDateWidget(
                        initial: request.endTime,
                        onSelect: (selected) {
                          endDateC.text = selected?.formatDate ?? '';
                          request.endTime = selected;
                          context
                              .read<InventoryCubit>()
                              .getInventory(context, request: request);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.0.verticalSpace,
            BlocBuilder<InventoryCubit, InventoryInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return Column(
                  children: [
                    10.0.verticalSpace,
                    Container(
                      decoration: MyStyle.roundBox,
                      padding: const EdgeInsets.all(20.0).r,
                      child: DrawableText(
                        text: groupCubit.state.getNameByGuid(request.groupGuid ?? ''),
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
                      data: state.result.mapIndexed((i, e) {
                        return [e.materialName, e.unit, e.quantity];
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
