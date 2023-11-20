import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/date_picker_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../../accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../../../accounts/data/request/account_request.dart';

class DebitPage extends StatefulWidget {
  const DebitPage({super.key});

  @override
  State<DebitPage> createState() => _DebitPageState();
}

class _DebitPageState extends State<DebitPage> {
  final request = AccountRequest(type: 'expenses');

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  @override
  void initState() {
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    // context.read<TransactionsCubit>().getTransactions(context,request: request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).netExpenses),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AccountsCubit, AccountsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return SpinnerWidget(
                  hint:
                      DrawableText(text: S.of(context).accountName, color: Colors.white),
                  items: state.getSpinnerItems(),
                  width: .9.sw,
                  onChanged: (val) {
                    request.accountGuid = val.guid;
                    context
                        .read<TransactionsCubit>()
                        .getTransactions(context, request: request);
                  },
                );
              },
            ),
            10.0.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
              child: Row(
                children: [
                  Expanded(
                    child: MyTextFormNoLabelWidget(
                      hint: 'تاريخ بداية',
                      textAlign: TextAlign.center,
                      controller: startDateC,
                      disableAndKeepIcon: true,
                      textDirection: TextDirection.ltr,
                      iconWidget: SelectSingeDateWidget(
                        initial: request.startTime,
                        onSelect: (selected) {
                          startDateC.text = selected?.formatDate ?? '';
                          request.startTime = selected;
                          context
                              .read<TransactionsCubit>()
                              .getTransactions(context, request: request);
                        },
                      ),
                    ),
                  ),
                  10.0.horizontalSpace,
                  Expanded(
                    child: MyTextFormNoLabelWidget(
                      hint: 'تاريخ نهاية',
                      textAlign: TextAlign.center,
                      controller: endDateC,
                      disableAndKeepIcon: true,
                      color: AppColorManager.mainColorLight.withOpacity(0.5),
                      textDirection: TextDirection.ltr,
                      iconWidget: SelectSingeDateWidget(
                        initial: request.endTime,
                        onSelect: (selected) {
                          endDateC.text = selected?.formatDate ?? '';
                          request.endTime = selected;
                          context
                              .read<TransactionsCubit>()
                              .getTransactions(context, request: request);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.0.verticalSpace,
            BlocBuilder<TransactionsCubit, TransactionsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return Expanded(
                  child: SaedTableWidget1(
                    title: [
                      S.of(context).accountName,
                      S.of(context).expense,
                      S.of(context).notes,
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
                            e.accountName,
                            e.paid,
                            e.note,
                          ],
                        )
                        .toList(),
                  ),
                );
              },
            ),
            BlocBuilder<TransactionsCubit, TransactionsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                var sum = 0.0;
                for (var e in state.result) {
                  sum += num.parse(e.paid);
                }
                return Container(
                  decoration: MyStyle.roundBox,
                  padding: const EdgeInsets.all(20.0).r,
                  child: DrawableText(
                    text: S.of(context).total,
                    matchParent: true,
                    drawableEnd: DrawableText(
                      text: sum.formatPrice,
                      fontFamily: FontManager.cairoBold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
