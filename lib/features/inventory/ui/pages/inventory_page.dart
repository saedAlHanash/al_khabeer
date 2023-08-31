import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/features/filter_data/bloc/material_cubit/material_cubit.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../bloc/inventory_cubit/inventory_cubit.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';
import '../../../filter_data/bloc/group_cubit/group_cubit.dart';

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

  @override
  void initState() {
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
            padding: EdgeInsets.all(5.0).r,
            margin: EdgeInsets.all(15.0).r,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DrawableText(
                        text: 'مجموع المواد',
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
                        text: 'الكميات',
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
      appBar: AppBarWidget(titleText: 'جرد المخازن'),
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
                  hint: DrawableText(text: 'المجموعة', color: Colors.white),
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
                  hint: DrawableText(text: 'المادة', color: Colors.white),
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
                      padding: EdgeInsets.all(20.0).r,
                      child: DrawableText(
                        text: groupCubit.state.getNameByGuid(request.groupGuid ?? ''),
                        matchParent: true,
                      ),
                    ),
                    10.0.verticalSpace,
                    SaedTableWidget1(
                      title: [
                        'اسم المادة',
                        'الوحدة',
                        'الكمية',
                      ],
                        data: state.result.mapIndexed((i, e) {
                          return [
                            e.materialName,
                            e.unit,
                            e.quantity
                          ];
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