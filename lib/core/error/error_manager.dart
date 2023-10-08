import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../router/app_router.dart';
import '../injection/injection_container.dart';
import '../util/shared_preferences.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppSharedPreference.logout();
        sl<GlobalKey<NavigatorState>>()
            .currentState
            ?.pushNamedAndRemoveUntil(RouteName.splash, (route) => false);
        return ' المستخدم الحالي لم يسجل الدخول ' '${response.statusCode}';

      case 503:
        return 'حدث تغيير في المخدم رمز الخطأ 503 ' '${response.statusCode}';
      case 481:
        return 'لا يوجد اتصال بالانترنت' '${response.statusCode}';

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(jsonDecode(response.body));

        return errorBody.message;
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.status,
    required this.message,
  });

  final String status;
  final String message;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    return ErrorBody(
      status: json["status"] ?? '',
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
