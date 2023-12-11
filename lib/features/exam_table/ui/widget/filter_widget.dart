import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../filter_data/bloc/class_cubit/class_cubit.dart';
import '../../../filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../../filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../data/request/exam_request.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key, required this.request});

  final ExamRequest request;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
      child: Column(
        children: [
          10.0.verticalSpace,
          BlocBuilder<ClassCubit, ClassInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return SpinnerWidget(
                hintText: S.of(context).stage,
                items: state.getSpinnerItems(selectedId: request.classGuid),
                width: .9.sw,
                onChanged: (val) {
                  request.setClass(val.guid);
                  context.read<ClassLevelCubit>().getClassLevel(
                        context,
                        parentGuid: request.classGuid,
                      );
                  context.read<StageCubit>().getStage(
                        context,
                        levelGuid: request.classLevelGuid,
                      );
                },
              );
            },
          ),
          10.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: BlocBuilder<ClassLevelCubit, ClassLevelInitial>(
                  builder: (context, state) {
                    if (request.classGuid == null) {
                      return 0.0.verticalSpace;
                    }
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return SpinnerWidget(
                      hintText: S.of(context).grade,
                      items: state.getSpinnerItems(selectedId: request.classLevelGuid),
                      width: .9.sw,
                      onChanged: (val) {
                        request.setLevel(val.guid);
                        context
                            .read<StageCubit>()
                            .getStage(context, levelGuid: request.classLevelGuid);
                      },
                    );
                  },
                ),
              ),
              10.0.horizontalSpace,
              Expanded(
                child: BlocBuilder<StageCubit, StageInitial>(
                  builder: (context, state) {
                    if (request.classGuid == null || request.classLevelGuid == null) {
                      return 0.0.verticalSpace;
                    }
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return SpinnerWidget(
                      hintText: S.of(context).section,
                      items: state.getSpinnerItems(selectedId: request.stageGuid),
                      width: .9.sw,
                      onChanged: (val) => request.stageGuid = val.guid,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
