import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_card_widget.dart';
import 'package:al_khabeer/core/widgets/not_found_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../bloc/employees_cubit/employees_cubit.dart';
import '../widget/employ_widget.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'ذاتية الموظفين'),
      body: BlocBuilder<EmployeesCubit, EmployeesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if(state.result.isEmpty){
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
