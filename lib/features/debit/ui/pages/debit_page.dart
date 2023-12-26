import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../accounts/bloc/account_by_id_cubit/account_by_id_cubit.dart';
import '../../../accounts/data/request/account_request.dart';
import '../../../filter_data/ui/widget/filter_account_widget.dart';

class DebitPage extends StatelessWidget {
  const DebitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).netExpenses),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FilterAccountWidget(filterName: 'expenses'),
            Expanded(
              child: BlocBuilder<AccountByIdCubit, AccountByIdInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return SaedTableWidget1(
                    title: [
                      S.of(context).accountName,
                      S.of(context).expense,
                    ],
                    data: state.result
                        .mapIndexed(
                          (i, e) => [
                            TableItem(
                              data: e.name,
                              background: e.isParent
                                  ? AppColorManager.black
                                  : null,
                            ),
                            TableItem(
                              data: e.balance.formatPrice,
                              background: e.isParent
                                  ? AppColorManager.black
                                  : null,
                            ),
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
