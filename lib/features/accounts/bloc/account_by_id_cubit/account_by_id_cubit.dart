import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/account_request.dart';
import '../../data/response/accouts_response.dart';

part 'account_by_id_state.dart';

class AccountByIdCubit extends Cubit<AccountByIdInitial> {
  AccountByIdCubit() : super(AccountByIdInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getAccountById(BuildContext context, {AccountRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _getAccountsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      final r = <AccountsData>[];
      for (var e in pair.first!) {
        e.isParent = true;
        r.addAll(getAllSubAccounts(e));
      }

      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: r,
        ),
      );
    }
  }

  Future<Pair<List<AccountsData>?, String?>> _getAccountsApi() async {
    if (await network.isConnected) {
      loggerObject.w(state.request.toJson());
      final response = await APIService().getApi(
        url: GetUrl.getAccountById,
        query: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(AccountsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
