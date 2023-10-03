import 'dart:async';

import 'package:logger/logger.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../util/shared_preferences.dart';

class InsertFirebaseTokenCubit {
  final network = sl<NetworkInfo>();

  insertFirebaseToken() async {
    if (!AppSharedPreference.isLogin) {
      return;
    }

    var token = AppSharedPreference.getFireToken();

    if (token.isEmpty) token = await getFireToken();

    final pair = await _insertFirebaseTokenApi(token: token);

    if (pair.first == null) {
      Timer(
        const Duration(seconds: 40),
        () => insertFirebaseToken(),
      );
    } else {
      Logger().e('done Done Fire token ');
      // emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _insertFirebaseTokenApi({required String token}) async {
    if (await network.isConnected) {
      final response = await APIService().uploadMultiPart(
        url: PostUrl.insertFireBaseToken,
        fields: {
          'device_name': 'android1',
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}
