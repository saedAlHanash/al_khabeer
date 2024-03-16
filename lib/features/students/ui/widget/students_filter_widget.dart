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
import '../../../filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../data/request/student_request.dart';

class StudentsFilterWidget extends StatefulWidget {
  const StudentsFilterWidget({super.key, required this.request});

  final StudentsRequest request;

  @override
  State<StudentsFilterWidget> createState() => _StudentsFilterWidgetState();
}

class _StudentsFilterWidgetState extends State<StudentsFilterWidget> {
  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  @override
  void initState() {
    startDateC = TextEditingController(text: widget.request.startTime?.formatDate);
    endDateC = TextEditingController(text: widget.request.endTime?.formatDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
      child: Column(
        children: [
          20.0.verticalSpace,
          ImageMultiType(
            url: Assets.iconsLogoWithoutText,
            height: 159.0.r,
            width: 159.0.r,
          ),
          BlocBuilder<ClassCubit, ClassInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return SpinnerWidget(
                hintText: S.of(context).stage,
                items: state.getSpinnerItems(selectedId: widget.request.classGuid),
                width: .9.sw,
                onChanged: (val) {
                  widget.request.setClass(val.guid);
                  context.read<ClassLevelCubit>().getClassLevel(
                        context,
                        parentGuid: widget.request.classGuid,
                      );
                  context.read<StageCubit>().getStage(
                        context,
                        levelGuid: widget.request.classLevelGuid,
                      );
                },
              );
            },
          ),
          BlocBuilder<ClassLevelCubit, ClassLevelInitial>(
            builder: (context, state) {
              if (widget.request.classGuid == null) {
                return 0.0.verticalSpace;
              }
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                children: [
                  20.0.verticalSpace,
                  SpinnerWidget(
                    hintText: S.of(context).grade,
                    items:
                        state.getSpinnerItems(selectedId: widget.request.classLevelGuid),
                    width: .9.sw,
                    onChanged: (val) {
                      widget.request.setLevel(val.guid);
                      context
                          .read<StageCubit>()
                          .getStage(context, levelGuid: widget.request.classLevelGuid);
                    },
                  ),
                ],
              );
            },
          ),
          BlocBuilder<StageCubit, StageInitial>(
            builder: (context, state) {
              if (widget.request.classGuid == null ||
                  widget.request.classLevelGuid == null) {
                return 0.0.verticalSpace;
              }
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                children: [
                  20.0.verticalSpace,
                  SpinnerWidget(
                    hintText: S.of(context).section,
                    items: state.getSpinnerItems(selectedId: widget.request.stageGuid),
                    width: .9.sw,
                    onChanged: (val) => widget.request.stageGuid = val.guid,
                  ),
                ],
              );
            },
          ),
          30.0.verticalSpace,
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
