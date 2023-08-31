import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../employees/ui/widget/employ_widget.dart';
import '../../bloc/teachers_cubit/teachers_cubit.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'ذاتية الموظفين'),
      body: BlocBuilder<TeachersCubit, TeachersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return NotFoundWidget(text: 'لا يوجد نتائج', icon: null);
          }
          return ListView.builder(
            itemCount: state.result.length,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0).r,
            itemBuilder: (_, i) => EmployWidget(data: state.result[i]),
          );
        },
      ),
    );
  }
}
