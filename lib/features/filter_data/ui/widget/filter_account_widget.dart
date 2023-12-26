import 'package:al_khabeer/core/extensions/extensions.dart';
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

class FilterAccountWidget extends StatefulWidget {
  const FilterAccountWidget({super.key, required this.filterName});
final String filterName;


  @override
  State<FilterAccountWidget> createState() => _FilterAccountWidgetState();
}

class _FilterAccountWidgetState extends State<FilterAccountWidget> {
  late final TextEditingController startDateC;
  late final TextEditingController endDateC;
  late final AccountRequest request;
  @override
  void initState() {
    request = AccountRequest(type: widget.filterName);
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AccountsCubit, AccountsInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SpinnerWidget(
              hintText: S.of(context).accountName,
              items: state.getSpinnerItems(selectedId: request.account?.guid),
              width: .9.sw,
              onChanged: (val) {
                request.account = val.item;
              },
            );
          },
        ),
        30.0.verticalSpace,
        Row(
          children: [
            Expanded(
              child: MyTextFormNoLabelWidget(
                hint: S.of(context).startDate,
                textAlign: TextAlign.center,
                controller: startDateC,
                disableAndKeepIcon: true,
                textDirection: TextDirection.ltr,
                iconWidget: SelectSingeDateWidget(
                  initial: request.startTime,
                  onSelect: (selected) {
                    startDateC.text = selected?.formatDate ?? '';
                    request.startTime = selected;
                  },
                ),
              ),
            ),
            16.0.horizontalSpace,
            Expanded(
              child: MyTextFormNoLabelWidget(
                hint: S.of(context).endDate,
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
                  },
                ),
              ),
            ),
          ],
        ),
        10.0.verticalSpace,
        BlocBuilder<AccountByIdCubit, AccountByIdInitial>(
          builder: (context, state) {
            return MyButton(
              text: S.of(context).preview,
              width: 240.0.w,
              enable: !state.statuses.loading,
              onTap: () {
                context
                    .read<AccountByIdCubit>()
                    .getAccountById(context, request: request);
              },
            );
          },
        ),
        10.0.verticalSpace,
      ],
    );
  }
}
