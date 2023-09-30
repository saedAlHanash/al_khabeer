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
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/account_request.dart';
import '../../data/response/transactions_response.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsInitial> {
  TransactionsCubit() : super(TransactionsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getTransactions(BuildContext context, {AccountRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading,request: request));

    final pair = await _getTransactionsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first,
          filtered: pair.first,
        ),
      );
    }
  }

  Future<Pair<List<TransactionsData>?, String?>> _getTransactionsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getTransactions,
        query: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(TransactionsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
