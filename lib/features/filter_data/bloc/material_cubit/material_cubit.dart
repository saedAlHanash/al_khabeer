import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/material_response.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialInitial> {
  MaterialCubit() : super(MaterialInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getMaterials(BuildContext context, {required String? groupGuid}) async {
    if (groupGuid == null) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: []));
    }
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getMaterialsApi(groupGuid: groupGuid);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<MaterialDate>?, String?>> _getMaterialsApi(
      {required String? groupGuid}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getMaterial,
        query: {'parent_guid': groupGuid},
      );

      if (response.statusCode == 200) {
        return Pair(MaterialResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
