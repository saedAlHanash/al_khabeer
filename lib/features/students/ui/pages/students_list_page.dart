import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/student_cubit/student_cubit.dart';
import '../../data/response/students_response.dart';

class StudentsListPage extends StatelessWidget {
  const StudentsListPage({super.key, required this.result});

  final List<Student> result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).studentBalances,
      ),
      bottomNavigationBar: BlocBuilder<StudentCubit, StudentInitial>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20.0).r,
            margin: const EdgeInsets.all(30.0).r,
            decoration: MyStyle.roundBox,
            child: DrawableText(
              text: S.of(context).total,
              matchParent: true,
              drawableEnd: DrawableText(
                text: (state.getAllStudentsBalance).formatPrice,
                fontFamily: FontManager.cairoBold.name,
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<StudentCubit, StudentInitial>(
        builder: (context, _) {
          return Column(
            children: [
              30.0.verticalSpace,
              Table3Item(
                title: [
                  S.of(context).name,
                  S.of(context).grade,
                  S.of(context).balance,
                ],
                data: result.mapIndexed((i, e) {
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
                    arguments: result[i],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
