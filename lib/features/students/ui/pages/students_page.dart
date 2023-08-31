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
import '../../../../router/app_router.dart';
import '../../../filter_data/bloc/class_cubit/class_cubit.dart';
import '../../../filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../bloc/student_cubit/student_cubit.dart';
import '../../data/request/student_request.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, this.withAppBar = true});

  final bool withAppBar;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final request = StudentsRequest();

  @override
  void initState() {
    context.read<StudentCubit>().getStudent(context, request: StudentsRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!widget.withAppBar)
          ? null
          : const AppBarWidget(
              titleText: 'أرصدة الطلاب',
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
                      request.classGuid = val.guid;
                      context.read<ClassLevelCubit>().getClassLevel(
                            context,
                            parentGuid: request.classGuid,
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
                    onChanged: (val) => request.classLevelGuid = val.guid,
                  );
                },
              ),
              10.0.verticalSpace,
              BlocBuilder<StudentCubit, StudentInitial>(
                builder: (context, state) {
                  return MyButton(
                    text: 'معاينة',
                    width: 240.0.w,
                    enable: !state.statuses.loading,
                    onTap: () {
                      context.read<StudentCubit>().getStudent(
                            context,
                            request: request,
                          );
                    },
                  );
                },
              ),
              10.0.verticalSpace,
              BlocBuilder<StudentCubit, StudentInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SaedTableWidget(
                    title: [
                      'الاسم',
                      'الصف',
                      'الرصيد',
                    ],
                    data: state.result.mapIndexed((i, e) {
                      return [
                        e.studentname,
                        e.className,
                        e.getAccountBalance.toString(),
                      ];
                    }).toList(),
                    onTapItem: (list, i) {
                      Navigator.pushNamed(
                        context,
                        RouteName.studentInfo,
                        arguments: state.result[i].studentguid,
                      );
                    },
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

final stageSpinnerItems = [
  SpinnerItem(id: -1, name: 'المرحلة'),
  SpinnerItem(id: 1, name: 'إعدادي'),
  SpinnerItem(id: 2, name: 'ابتدائي '),
  SpinnerItem(id: 3, name: 'ثانوي'),
];

final classSpinnerItems = [
  SpinnerItem(id: -1, name: 'الصف'),
  SpinnerItem(id: 1, name: 'أول'),
  SpinnerItem(id: 2, name: 'ثاني '),
  SpinnerItem(id: 3, name: 'ثالث'),
];
