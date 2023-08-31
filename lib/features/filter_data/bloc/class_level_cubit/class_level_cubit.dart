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
import '../../data/response/class_response.dart';
import '../../data/response/material_response.dart';

part 'class_level_state.dart';

class ClassLevelCubit extends Cubit<ClassLevelInitial> {
  ClassLevelCubit() : super(ClassLevelInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getClassLevel(BuildContext context, {String? parentGuid}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getClassLevelApi(parentGuid: parentGuid);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<ClassData>?, String?>> _getClassLevelApi({String? parentGuid}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getClassLevel,
        query: {'stage_guid': parentGuid},
      );

      if (response.statusCode == 200) {
        return Pair(ClassResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
