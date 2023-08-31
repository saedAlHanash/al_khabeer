import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/inventory/data/response/inventory_response.dart';
import 'package:al_khabeer/features/news/data/response/mews_response.dart';
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

part 'news_state.dart';

class NewsCubit extends Cubit<NewsInitial> {
  NewsCubit() : super(NewsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getNews(BuildContext context, ) async {
    emit(state.copyWith(statuses: CubitStatuses.loading ));

    final pair = await _getNewsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<NewsData>?, String?>> _getNewsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getNews,

      );

      if (response.statusCode == 200) {
        return Pair(NewsResponse.fromJson(response.jsonBody).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
