import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/features/cash_account/ui/pages/cash_account_page.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../../accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../../../exam_table/ui/pages/exam_table_page.dart';

class DebitPage extends StatefulWidget {
  const DebitPage({super.key});

  @override
  State<DebitPage> createState() => _DebitPageState();
}

class _DebitPageState extends State<DebitPage> {
  @override
  void initState() {
    context.read<TransactionsCubit>().getTransactions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'صافي المصاريف'),
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
                  hint: DrawableText(text: 'اسم الحساب', color: Colors.white),
                  items: state.getSpinnerItems(),
                  width: .9.sw,
                  onChanged: (val) {
                    context.read<TransactionsCubit>().getTransactions(
                          context,
                          guid: val.guid,
                        );
                  },
                );
              },
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
                      'اسم الحساب',
                      'المصروف',
                      'ملاحظات',
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
                            e.accountName,
                            e.paid.toString(),
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
                  padding: EdgeInsets.all(20.0).r,
                  child: DrawableText(
                    text: 'مجموع',
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
