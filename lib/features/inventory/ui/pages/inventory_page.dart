import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/my_style.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/features/filter_data/bloc/material_cubit/material_cubit.dart';
import 'package:al_khabeer/features/inventory/ui/widget/inventory_filter_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/date_picker_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../filter_data/bloc/group_cubit/group_cubit.dart';
import '../../bloc/inventory_cubit/inventory_cubit.dart';
import '../../data/request/inventory_request.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final request = InventoryRequest();

  late final GroupCubit groupCubit;
  late final MaterialCubit materialCubit;

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;

  @override
  void initState() {
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    groupCubit = context.read<GroupCubit>();
    materialCubit = context.read<MaterialCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryCubit, InventoryInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pushNamed(context, RouteName.inventoryList, arguments: state);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: S.of(context).inventory,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InventoryFilterWidget(request: request),
            20.0.verticalSpace,
            BlocBuilder<InventoryCubit, InventoryInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  text: S.of(context).preview,
                  width: 240.0.w,
                  onTap: () {
                    context.read<InventoryCubit>().getInventory(
                          context,
                          request: request,
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
