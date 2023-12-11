import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/filter_data/ui/widget/filter_account_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/date_picker_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../accounts/bloc/account_by_id_cubit/account_by_id_cubit.dart';
import '../../../accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../../accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../../../accounts/data/request/account_request.dart';

class CashAccount extends StatefulWidget {
  const CashAccount({super.key});

  @override
  State<CashAccount> createState() => _CashAccountState();
}

class _CashAccountState extends State<CashAccount> {
  final request = AccountRequest(type: 'ready');

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  @override
  void initState() {
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).studentAccounts),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilterAccountWidget(request: request),
            Expanded(
              child: BlocBuilder<AccountByIdCubit, AccountByIdInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SaedTableWidget1(
                    title: [
                      S.of(context).accountName,
                      S.of(context).balance,
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
                            e.name,
                            e.balance.formatPrice,
                          ],
                        )
                        .toList(),
                  );
                },
              ),
            ),
            BlocBuilder<AccountByIdCubit, AccountByIdInitial>(
              builder: (context, state) {
                return Container(
                  decoration: MyStyle.roundBox,
                  padding: const EdgeInsets.all(20.0).r,
                  child: DrawableText(
                    text: S.of(context).total,
                    matchParent: true,
                    drawableEnd: DrawableText(
                      text: (state.getAllAccountBalance).formatPrice,
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
