import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../../accounts/bloc/transactions_cubit/transactions_cubit.dart';

class AuditPage extends StatefulWidget {
  const AuditPage({super.key});

  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  @override
  void initState() {
    context.read<TransactionsCubit>().getTransactions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).netRevenue),
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
                  hint: DrawableText(text: S.of(context).accountName, color: Colors.white),
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
                      S.of(context).accountName,
                      S.of(context).revenue,
                      S.of(context).notes,
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
                            e.accountName,
                            e.caught.toString(),
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
                  sum += num.parse(e.caught);
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
