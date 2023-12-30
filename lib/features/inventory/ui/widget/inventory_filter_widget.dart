import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/enum_manager.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/date_picker_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../filter_data/bloc/class_cubit/class_cubit.dart';
import '../../../filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../../filter_data/bloc/group_cubit/group_cubit.dart';
import '../../../filter_data/bloc/material_cubit/material_cubit.dart';
import '../../../filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../bloc/inventory_cubit/inventory_cubit.dart';
import '../../data/request/inventory_request.dart';

class InventoryFilterWidget extends StatefulWidget {
  const InventoryFilterWidget({super.key, required this.request});

  final InventoryRequest request;

  @override
  State<InventoryFilterWidget> createState() => _InventoryFilterWidgetState();
}

class _InventoryFilterWidgetState extends State<InventoryFilterWidget> {
  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  late final GroupCubit groupCubit;
  late final MaterialCubit materialCubit;

  @override
  void initState() {
    startDateC = TextEditingController(text: widget.request.startTime?.formatDate);
    endDateC = TextEditingController(text: widget.request.endTime?.formatDate);
    groupCubit = context.read<GroupCubit>();
    materialCubit = context.read<MaterialCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      child: Column(
        children: [
          20.0.verticalSpace,
         ImageMultiType(
            url: Assets.iconsLogoWithoutText,
            height: 160.0.r,
            width: 160.0.r,
          ),

          BlocBuilder<GroupCubit, GroupInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return SpinnerWidget(
                hintText: S.of(context).group,
                items: state.getSpinnerItems(selectedId: widget.request.groupGuid),
                width: .9.sw,
                onChanged: (val) {
                  widget.request.groupGuid = val.guid;
                  //get material Data
                  context.read<MaterialCubit>().getMaterials(
                        context,
                        groupGuid: val.guid,
                      );
                },
              );
            },
          ),
          BlocBuilder<MaterialCubit, MaterialInitial>(
            builder: (context, state) {
              if (widget.request.groupGuid == null) {
                return 0.0.verticalSpace;
              }
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                children: [
                  20.0.verticalSpace,
                  SpinnerWidget(
                    hintText: S.of(context).subjectName,
                    items: state.getSpinnerItems(selectedId: widget.request.materialGuid),
                    width: .9.sw,
                    onChanged: (val) {
                      widget.request.materialGuid = val.guid;
                    },
                  ),
                ],
              );
            },
          ),
          20.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  hint: S.of(context).startDate,
                  textAlign: TextAlign.center,
                  controller: startDateC,
                  disableAndKeepIcon: true,
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: widget.request.startTime,
                    onSelect: (selected) {
                      startDateC.text = selected?.formatDate ?? '';
                      widget.request.startTime = selected;
                    },
                  ),
                ),
              ),
              16.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  hint: S.of(context).endDate,
                  textAlign: TextAlign.center,
                  controller: endDateC,
                  disableAndKeepIcon: true,
                  color: AppColorManager.mainColorLight.withOpacity(0.5),
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: widget.request.endTime,
                    onSelect: (selected) {
                      endDateC.text = selected?.formatDate ?? '';
                      widget.request.endTime = selected;
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
