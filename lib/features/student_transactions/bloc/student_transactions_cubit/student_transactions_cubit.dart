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
import '../../data/request/student_transactions_request.dart';
import '../../data/response/student_transactions_response.dart';

part 'student_transactions_state.dart';

class StudentTransactionsCubit extends Cubit<StudentTransactionsInitial> {
  StudentTransactionsCubit() : super(StudentTransactionsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getStudentTransactions(BuildContext context,
      {StudentTransactionsRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _getStudentTransactionsApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<StudentTransactionsData>?, String?>> _getStudentTransactionsApi(
      {required StudentTransactionsRequest? request}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getStudentTransactions,
        query: request?.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(StudentTransactionsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
