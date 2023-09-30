import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/not_found_widget.dart';
import 'package:al_khabeer/core/widgets/saed_taple_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../student_transactions/bloc/student_transactions_cubit/student_transactions_cubit.dart';
import '../../../student_transactions/data/response/student_transactions_response.dart';
import '../../data/response/students_respose.dart';

class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage({super.key});

  // final List<dynamic> studentInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
        titleText: S.of(context).studentInformation,
      ),
      body: SizedBox.expand(
        child: BlocBuilder<StudentTransactionsCubit, StudentTransactionsInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            if (state.result.isEmpty) {
              return NotFoundWidget(text: S.of(context).noDetailsAvailable, icon: null);
            }
            final item = state.result.first;
            var sumCaught = 0.0;
            var sumPaid = 0.0;
            for (var e in state.result) {
              sumCaught += num.tryParse(e.caught) ?? 0;
              sumPaid += num.tryParse(e.paid) ?? 0;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.0.verticalSpace,
                SaedTableWidget(
                  title: [
                    S.of(context).name,
                    S.of(context).grade,
                       S.of(context).balance,
                  ],
                  data: [
                    [
                      item.studentName,
                      item.className,
                      (sumCaught - sumPaid).toString(),
                    ]
                  ],
                ),
                Container(
                  width: .9.sw,
                  padding: const EdgeInsets.all(20.0).r,
                  decoration: MyStyle.roundBox,
                  child: Column(
                    children: [
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        matchParent: true,
                        text: S.of(context).totalPaymentAmount,
                        drawableEnd: DrawableText(
                          fontFamily: FontManager.cairoBold,
                          text: sumPaid.formatPrice,
                        ),
                      ),
                      DrawableText(
                        color: AppColorManager.mainColor.withOpacity(0.6),
                        matchParent: true,
                        text: S.of(context).stageAndAdditions,
                      ),
                      10.0.verticalSpace,
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        matchParent: true,
                        text: S.of(context).remainingInstallmentAmount,
                        drawableEnd: DrawableText(
                          fontFamily: FontManager.cairoBold,
                          text: sumCaught.formatPrice,
                        ),
                      ),
                      DrawableText(
                        color: AppColorManager.mainColor.withOpacity(0.6),
                        matchParent: true,
                        text: S.of(context).stageAndAdditions,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(child: MyStepper(list: state.result)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MyStepper extends StatelessWidget {
  const MyStepper({super.key, required this.list});

  final List<StudentData> list;

  @override
  Widget build(BuildContext context) {
    final list = <StudentData>[...this.list]
      ..removeWhere((e) => num.parse(e.paid) <= 0);
    return Padding(
      padding: const EdgeInsets.all(20.0).r,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 20.0).h,
        children: list
            .mapIndexed((i, e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawableText(
                      matchParent: true,
                      text: e.date?.formatDate ?? '-',
                      drawableStart: Icon(
                        Icons.check_circle,
                        size: 20.0.r,
                        color: AppColorManager.mainColor,
                      ),
                      drawableEnd: DrawableText(
                        text: num.tryParse(e.paid)?.formatPrice ?? '-',
                      ),
                    ),
                    if (i < list.length - 1)
                      Container(
                        height: 50.0.h,
                        margin: const EdgeInsets.only(right: 10.0).r,
                        color: Colors.grey,
                        width: 2.0.w,
                      ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
