import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/exam_table/data/request/exam_request.dart';
import 'package:al_khabeer/features/exam_table/data/response/exam_response.dart';
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

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamInitial> {
  ExamCubit() : super(ExamInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> exam(BuildContext context, {required ExamRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _examApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Exam>?, String?>> _examApi({required ExamRequest request}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.exam,
        query: request.toJson(),
      );

      if (response.statusCode == 200) {
        final exams = ExamResponse.fromJson(response.jsonBody).data;

        return Pair(exams.lastOrNull?.exams ?? <Exam>[], null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
