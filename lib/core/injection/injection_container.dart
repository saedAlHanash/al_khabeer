import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../features/accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/logout/logout_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';

import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';

import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';

import '../../features/exam_table/bloc/exam_cubit/exam_cubit.dart';
import '../../features/filter_data/bloc/class_cubit/class_cubit.dart';
import '../../features/filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../features/filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../features/inventory/bloc/inventory_cubit/inventory_cubit.dart';
import '../../features/filter_data/bloc/group_cubit/group_cubit.dart';
import '../../features/filter_data/bloc/material_cubit/material_cubit.dart';
import '../../features/firebase/bloc/insert_firebase_token_cubit/insert_firebase_token_cubit.dart';

import '../../features/home/bloc/slider_cubit/slider_cubit.dart';

import '../../features/employees/bloc/employees_cubit/employees_cubit.dart';
import '../../features/news/bloc/news_cubit/news_cubit.dart';
import '../../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';

import '../../features/student_transactions/bloc/student_transactions_cubit/student_transactions_cubit.dart';
import '../../features/students/bloc/student_cubit/student_cubit.dart';
import '../../features/teachers/bloc/teachers_cubit/teachers_cubit.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory(() => NotificationCountCubit());

  sl.registerLazySingleton(() => LoadingCubit());

  sl.registerLazySingleton(() => InsertFirebaseTokenCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion

  //region auth
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => DeleteAccountCubit());

  //endregion

  //region filters data

  sl.registerFactory(() => MaterialCubit());
  sl.registerFactory(() => GroupCubit());
//endregion

  //region home
  sl.registerFactory(() => SliderCubit());
  sl.registerFactory(() => LogoutCubit());

  sl.registerFactory(() => NotificationsCubit());

  //endregion

  //region BestSeller

  //endregion

  //region inventory

  //endregion

  sl.registerFactory(() => InventoryCubit());
  sl.registerFactory(() => TeachersCubit());
  sl.registerFactory(() => StudentCubit());
  sl.registerFactory(() => StudentTransactionsCubit());
  sl.registerFactory(() => ExamCubit());

  //region Cart

  //region employees
  sl.registerFactory(() => EmployeesCubit());

  //endregion

  sl.registerFactory(() => AddToCartCubit());
  sl.registerFactory(() => CouponCubit());
  sl.registerFactory(() => ClassCubit());
  sl.registerFactory(() => ClassLevelCubit());
  sl.registerFactory(() => StageCubit());
  sl.registerFactory(() => TransactionsCubit());
  sl.registerFactory(() => AccountsCubit());
  sl.registerFactory(() => NewsCubit());

  //endregion

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
