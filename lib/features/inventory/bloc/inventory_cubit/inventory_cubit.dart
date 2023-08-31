import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/inventory/data/response/inventory_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../data/request/inventory_request.dart';


part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryInitial> {
  InventoryCubit() : super(InventoryInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getInventory(BuildContext context,
      { InventoryRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _getInventoryApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<InventoryData>?, String?>> _getInventoryApi(
      {required InventoryRequest? request}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getInventory,
        query: request?.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(InventoryResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
