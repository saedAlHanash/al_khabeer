import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../filter_data/bloc/class_cubit/class_cubit.dart';
import '../../../filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../../filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../../students/data/request/student_request.dart';
import '../../../students/ui/pages/students_page.dart';
import '../../bloc/exam_cubit/exam_cubit.dart';
import '../../data/request/exam_request.dart';

class ExamTablePage extends StatefulWidget {
  const ExamTablePage({super.key});

  @override
  State<ExamTablePage> createState() => _ExamTablePageState();
}

class _ExamTablePageState extends State<ExamTablePage> {
  final request = ExamRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'جدول الامتحانات',
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ClassCubit, ClassInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SpinnerWidget(
                    hint: DrawableText(text: 'المرحلة', color: Colors.white),
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
              BlocBuilder<ClassLevelCubit, ClassLevelInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SpinnerWidget(
                    hint: DrawableText(text: 'الصف', color: Colors.white),
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
              10.0.verticalSpace,
              BlocBuilder<StageCubit, StageInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SpinnerWidget(
                    hint: DrawableText(text: 'الشعبة', color: Colors.white),
                    items: state.getSpinnerItems(selectedId: request.stageGuid),
                    width: .9.sw,
                    onChanged: (val) => request.stageGuid = val.guid,
                  );
                },
              ),
              10.0.verticalSpace,
              BlocBuilder<ExamCubit, ExamInitial>(
                builder: (context, state) {
                  return MyButton(
                    enable: !state.statuses.loading,
                    text: 'معاينة',
                    width: 240.0.w,
                    onTap: () =>
                        context.read<ExamCubit>().exam(context, request: request),
                  );
                },
              ),
              10.0.verticalSpace,
              BlocBuilder<ExamCubit, ExamInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SaedTableWidget(
                    title: [
                      'تاريخ',
                      'يوم',
                      'نوع الامتحان',
                      'اسم المادة',
                      'ملاحظات',
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) =>
                      [
                        e.date?.formatDateMD,
                        e.date?.formatDayName,
                        e.type,
                        e.material,
                        e.note,
                      ],
                    )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final tempSpinnerItems = [
  SpinnerItem(id: 1, name: 'saed1 test'),
  SpinnerItem(id: 2, name: 'saed2 test'),
  SpinnerItem(id: 3, name: 'saed3 test'),
];
