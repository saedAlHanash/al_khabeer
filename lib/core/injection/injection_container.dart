import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/logout/logout_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';


import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';

import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';

import '../../features/firebase/bloc/insert_firebase_token_cubit/insert_firebase_token_cubit.dart';


import '../../features/home/bloc/slider_cubit/slider_cubit.dart';

import '../../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';

import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';

import '../../features/settings/bloc/update_user_cubit/update_user_cubit.dart';
import '../../features/settings/services/setting_service.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory(() => NotificationCountCubit());

  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerLazySingleton(() => SettingService());
  sl.registerLazySingleton(() => InsertFirebaseTokenCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion

  //region auth
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => GetMeCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => DeleteAccountCubit());

  //endregion

  // region profile
  sl.registerFactory(() => UpdateProfileCubit());
  //endregion

  //region home
  sl.registerFactory(() => SliderCubit());
  sl.registerFactory(() => LogoutCubit());
  sl.registerFactory(() => UpdateUserCubit());
  sl.registerFactory(() => NotificationsCubit());

  //endregion



  //region BestSeller

  //endregion



  //region Cart

  sl.registerFactory(() => AddToCartCubit());
  sl.registerFactory(() => CouponCubit());

  //endregion





//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
