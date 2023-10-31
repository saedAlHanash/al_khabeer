import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/students/data/request/student_request.dart';
import 'package:al_khabeer/features/students/data/response/students_respose.dart';
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
import '../../data/response/students_response.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentInitial> {
  StudentCubit() : super(StudentInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getStudent(BuildContext context, {StudentsRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _getStudentApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!));
    }
  }

// // Define a helper method to group the items
//   List<StudentData> groupItems(List<StudentData> items) {
//     Map<String, List<StudentData>> groupedMap = {};
//     final list = <StudentData>[];
//
//     for (var item in items) {
//       if (groupedMap.containsKey(item.studentguid)) {
//         groupedMap[item.studentguid]!.add(item);
//       } else {
//         groupedMap[item.studentguid] = [item];
//       }
//     }
//     groupedMap.forEach((key, value) {
//       var accountBalance = 0.0;
//       for (var e in value) {
//         accountBalance += e.getAccountBalance;
//       }
//       final item = value.first..accountBalance = accountBalance;
//       list.add(item);
//     });
//
//     return list;
//   }

  Future<Pair<List<Student>?, String?>> _getStudentApi(
      {required StudentsRequest? request}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getStudent,
        query: request?.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(StudentsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
