import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:al_khabeer/features/exam_table/ui/widget/filter_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../filter_data/bloc/class_cubit/class_cubit.dart';
import '../../../filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../../filter_data/bloc/stage_cubit/stage_cubit.dart';
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
      appBar: AppBarWidget(
        titleText: S.of(context).examsSchedule,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilterWidget(request: request),
              10.0.verticalSpace,
              BlocBuilder<ExamCubit, ExamInitial>(
                builder: (context, state) {
                  return MyButton(
                    enable: !state.statuses.loading,
                    text: S.of(context).preview,
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
                      S.of(context).date,
                      S.of(context).day,
                      S.of(context).examType,
                      S.of(context).subjectName,
                      S.of(context).notes,
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
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
