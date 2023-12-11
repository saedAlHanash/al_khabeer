import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/student_cubit/student_cubit.dart';
import '../../data/request/student_request.dart';
import '../widget/students_filter_widget.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, this.withAppBar = true});

  final bool withAppBar;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late final StudentsRequest request;

  @override
  void initState() {
    request = context.read<StudentCubit>().state.request;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!widget.withAppBar)
          ? null
          : AppBarWidget(
              titleText: S.of(context).studentBalances,
            ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StudentsFilterWidget(request: request),
              10.0.verticalSpace,
              BlocBuilder<StudentCubit, StudentInitial>(
                builder: (context, state) {
                  return MyButton(
                    text: S.of(context).preview,
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
                      S.of(context).name,
                      S.of(context).grade,
                      S.of(context).balance,
                    ],
                    data: state.result.mapIndexed((i, e) {
                      return [
                        e.studentName,
                        e.className,
                        e.balance.formatPrice,
                      ];
                    }).toList(),
                    onTapItem: (list, i) {
                      Navigator.pushNamed(
                        context,
                        RouteName.studentInfo,
                        arguments: state.result[i],
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
