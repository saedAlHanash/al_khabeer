import 'package:al_khabeer/core/app/bloc/loading_cubit.dart';
import 'package:al_khabeer/core/strings/enum_manager.dart';
import 'package:al_khabeer/features/auth/data/request/signup_request.dart';

import 'package:al_khabeer/features/notifications/ui/pages/notifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/audit/ui/pages/audit_page.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/logout/logout_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';

import '../features/cart/bloc/coupon_cubit/coupon_cubit.dart';

import '../features/cash_account/ui/pages/cash_account_page.dart';
import '../features/debit/ui/pages/debit_page.dart';
import '../features/demo/ui/pages/demo.dart';
import '../features/employees/ui/pages/employees_page.dart';
import '../features/exam_table/ui/pages/exam_table_page.dart';

import '../features/home/bloc/slider_cubit/slider_cubit.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/inventory/ui/pages/inventory_page.dart';
import '../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';

import '../features/policy/ui/pages/policy.dart';
import '../features/settings/bloc/update_user_cubit/update_user_cubit.dart';
import '../features/settings/ui/pages/about_page.dart';
import '../features/settings/ui/pages/privacy_page.dart';
import '../features/settings/ui/pages/update_choice_page.dart';
import '../features/settings/ui/pages/update_page.dart';
import '../features/students/ui/pages/student_info_page.dart';
import '../features/students/ui/pages/students_page.dart';
import '../features/teachers/ui/pages/teachers_page.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    switch (screenName) {
      //region auth
      case RouteName.splash:
        //region
        return CupertinoPageRoute(builder: (_) => const SplashScreenPage());
      //endregion
      case RouteName.signup:
        //region
        {
          return CupertinoPageRoute(
            builder: (context) {
              final providers = [
                BlocProvider(create: (context) => di.sl<SignupCubit>()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const SignupPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.myAddress:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<SignupCubit>()),
          ];
          return CupertinoPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: MyAddress(request: settings.arguments as SignupRequest),
              );
            },
          );
        }
      //endregion
      case RouteName.login:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<LoginCubit>()),
          ];
          return CupertinoPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const LoginPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.forgetPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ResendCodeCubit>()),
          ];
          return CupertinoPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ForgetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.resetPasswordPage:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ResetPasswordCubit>()),
          ];
          return CupertinoPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ResetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.confirmCode:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => di.sl<ConfirmCodeCubit>()),
            BlocProvider(create: (context) => di.sl<ResendCodeCubit>()),
          ];
          return CupertinoPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: providers,
                child: const ConfirmCodePage(),
              );
            },
          );
        }
      //endregion
      //endregion

      //region home
      case RouteName.home:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<SliderCubit>()..getSlider(_)),
          BlocProvider(create: (_) => di.sl<LogoutCubit>()),
          BlocProvider(create: (_) => di.sl<DeleteAccountCubit>()),
          BlocProvider(create: (_) => di.sl<CouponCubit>()),
          BlocProvider(create: (_) => di.sl<NotificationCountCubit>()),
          BlocProvider(create: (_) => di.sl<NotificationsCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const Homepage(),
            );
          },
        );
      //endregion

      case RouteName.examTable:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const ExamTablePage(),
            );
          },
        );
      //endregion

      case RouteName.students:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const StudentsPage(),
            );
          },
        );
      //endregion

      case RouteName.debit:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const DebitPage(),
            );
          },
        );
      //endregion

      case RouteName.audit:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const AuditPage(),
            );
          },
        );
      //endregion

      case RouteName.teachers:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const TeachersPage(),
            );
          },
        );
      //endregion

      case RouteName.employees:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const EmployeesPage(),
            );
          },
        );
      //endregion

      case RouteName.studentInfo:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: StudentInfoPage(studentInfo: settings.arguments as List),
            );
          },
        );
      //endregion

      case RouteName.cashAccount:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const CashAccount(),
            );
          },
        );
      //endregion

      case RouteName.notifications:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<NotificationsCubit>()..getNotifications(_)),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const NotificationsPage(),
            );
          },
        );
      //endregion

      case RouteName.demo:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<NotificationsCubit>()..getNotifications(_)),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const DemoPage(),
            );
          },
        );
      //endregion

      //endregion
      case RouteName.policy:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<NotificationsCubit>()..getNotifications(_)),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const PolicyPage(),
            );
          },
        );
      //endregion

      //endregion

      //region settings
      case RouteName.update:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<UpdateUserCubit>()),
        ];
        return CupertinoPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: UpdatePage(
                updateType: (settings.arguments ?? UpdateType.name) as UpdateType,
              ),
            );
          },
        );
      //endregion

      case RouteName.updateChoice:
        //region
        return CupertinoPageRoute(
          builder: (context) {
            return const UpdateChoicePage();
          },
        );
      //endregion
      case RouteName.about:
        //region
        return CupertinoPageRoute(
          builder: (context) {
            return const AboutPage();
          },
        );
      //endregion
      case RouteName.privacy:
        //region
        return CupertinoPageRoute(
          builder: (context) {
            return const PrivacyPage();
          },
        );
      //endregion

      //endregion

      //region inventory
      case RouteName.inventory:
        final providers = [
          BlocProvider(
            create: (context) => di.sl<LoadingCubit>(),
          ),
        ];
        return CupertinoPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: InventoryPage(),
          );
        });

      //endregion
    }

    return CupertinoPageRoute(builder: (_) => const Scaffold(backgroundColor: Colors.red));
  }
}

class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/1';
  static const home = '/2';
  static const forgetPassword = '/3';
  static const resetPasswordPage = '/4';
  static const login = '/5';
  static const signup = '/6';
  static const confirmCode = '/7';
  static const myAddress = '/8';
  static const product = '/9';
  static const profile = '/10';
  static const searchResult = '/11';
  static const update = '/12';
  static const updateChoice = '/13';
  static const notifications = '/14';
  static const offers = '/15';
  static const examTable = '/16';
  static const myOrders = '/17';
  static const about = '/18';
  static const privacy = '/19';
  static const inventory = '/20';
  static const cashAccount = '/21';
  static const students = '/22';

  static const studentInfo = '/23';
  static const debit = '/24';
  static const audit = '/25';
  static const teachers = '/26';
  static const employees = '/27';
  static const demo = '/28';
  static const policy = '/29';
}
