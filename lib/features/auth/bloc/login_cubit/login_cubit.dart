import 'dart:convert';

import 'package:al_khabeer/core/api_manager/api_url.dart';
import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/util/shared_preferences.dart';
import 'package:al_khabeer/features/auth/data/request/login_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> login(BuildContext context, {required LoginRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _loginApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
        emit(state.copyWith(statuses: CubitStatuses.error));
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashToken(pair.first!.token);
      AppSharedPreference.cashUser(pair.first!.user);
      AppSharedPreference.cashLoginData(pair.first!);
      AppSharedPreference.cashMyId(pair.first!.user.id);

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginData?, String?>> _loginApi({required LoginRequest request}) async {
    if (await network.isConnected) {
      final response =
          await APIService().postApi(url: PostUrl.loginUrl, body: request.toJson());

      if (response.statusCode.success) {
        return Pair(LoginResponse.fromJson(jsonDecode(response.body)).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
