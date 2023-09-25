import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../../inventory/data/request/inventory_request.dart';
import '../../data/response/emploees_response.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesInitial> {
  EmployeesCubit() : super(EmployeesInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getEmployees(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getEmployeesApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<EmployData>?, String?>> _getEmployeesApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getEmployees,
      );

      if (response.statusCode == 200) {
        return Pair(EmployeesResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
