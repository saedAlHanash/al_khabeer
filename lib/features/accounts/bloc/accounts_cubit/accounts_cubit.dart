import 'package:al_khabeer/core/extensions/extensions.dart';
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

import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/accouts_response.dart';
import '../../data/response/transactions_response.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsInitial> {
  AccountsCubit() : super(AccountsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getAccounts(BuildContext context, {String? guid}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getAccountsApi(guid: guid);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: guid == null ? pair.first : null,
          filtered: pair.first,
        ),
      );
    }
  }

  Future<Pair<List<AccountsData>?, String?>> _getAccountsApi(
      {String? guid}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getAccounts,
        query: {'account_guid': guid},
      );

      if (response.statusCode == 200) {
        return Pair(AccountsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
