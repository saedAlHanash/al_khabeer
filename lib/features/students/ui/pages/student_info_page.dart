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
import '../../data/response/students_response.dart';
import '../../data/response/students_respose.dart';

class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).studentInformation,
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.0.verticalSpace,
            Table3Item(
              title: [
                S.of(context).name,
                S.of(context).grade,
                S.of(context).balance,
              ],
              data: [
                [
                  student.studentName,
                  student.className,
                  student.balance.formatPrice,
                ]
              ],
            ),
            Container(

              padding: const EdgeInsets.all(20.0).r,
              margin: const EdgeInsets.all( 30.0).r,
              decoration: MyStyle.roundBox,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DrawableText(
                              color: AppColorManager.newsHeader,
                              text: S.of(context).totalPaymentAmount,
                              size: 18.0.sp,
                            ),
                            DrawableText(
                              color: AppColorManager.newsHeader,
                              size: 16.0.sp,
                              text: S.of(context).stageAndAdditions,
                            ),
                          ],
                        ),
                      ),
                      DrawableText(
                        size: 18.0.sp,
                        color: AppColorManager.newsHeader,
                        fontFamily: FontManager.cairoBold.name,
                        text: num.tryParse(student.sumPaid.toString())?.formatPrice ??
                            student.sumPaid,
                      ),
                    ],
                  ),
                  15.0.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DrawableText(
                              size: 18.0.sp,
                              text: S.of(context).remainingInstallmentAmount,
                              color: AppColorManager.newsHeader,
                            ),
                            DrawableText(
                              size: 16.0.sp,
                              color: AppColorManager.newsHeader,
                              text: S.of(context).stageAndAdditions,
                            ),
                          ],
                        ),
                      ),
                      DrawableText(
                        size: 18.0.sp,
                        color: AppColorManager.newsHeader,
                        fontFamily: FontManager.cairoBold.name,
                        text: num.tryParse(student.sumCaught)?.formatPrice ??
                            student.sumCaught,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: MyStepper(list: student.transactions),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatelessWidget {
  const MyStepper({super.key, required this.list});

  final List<Transaction> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).r,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0).r,
            child: Row(
              children: [
                Expanded(
                  child: DrawableText(
                      size: 20.0.sp,
                      color: AppColorManager.newsHeader,
                      matchParent: true,
                      text: S.of(context).payDate),
                ),
                Expanded(
                  child: DrawableText(
                    size: 20.0.sp,
                    color: AppColorManager.newsHeader,
                    textAlign: TextAlign.center,
                    text: S.of(context).paid,
                  ),
                ),
                Expanded(
                  child: DrawableText(
                    size: 20.0.sp,
                    color: AppColorManager.newsHeader,
                    textAlign: TextAlign.center,
                    text: S.of(context).caught,
                  ),
                ),
              ],
            ),
          ),
          10.0.verticalSpace,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 30.0).h,
              children: list
                  .mapIndexed((i, e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DrawableText(
                                  size: 20.0.sp,
                                  fontFamily: FontManager.cairoBold.name,
                                  color: AppColorManager.newsHeader,
                                  matchParent: true,
                                  text: e.date?.formatDate ?? '-',
                                  drawableStart: Icon(
                                    Icons.check_circle,
                                    size: 18.0.r,
                                    color: AppColorManager.mainColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: DrawableText(
                                  size: 18.0.sp,
                                  fontFamily: FontManager.cairoBold.name,
                                  color: AppColorManager.newsHeader,
                                  textAlign: TextAlign.center,
                                  text: num.tryParse(e.paid)?.formatPrice ?? '-',
                                ),
                              ),
                              Expanded(
                                child: DrawableText(
                                  size: 18.0.sp,
                                  fontFamily: FontManager.cairoBold.name,
                                  color: AppColorManager.newsHeader,
                                  textAlign: TextAlign.center,
                                  text: num.tryParse(e.caught)?.formatPrice ?? '-',
                                ),
                              ),
                            ],
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
          ),
        ],
      ),
    );
  }
}
