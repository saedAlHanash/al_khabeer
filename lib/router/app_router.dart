import 'package:al_khabeer/core/api_manager/api_service.dart';
import 'package:al_khabeer/core/app/bloc/loading_cubit.dart';
import 'package:al_khabeer/features/notifications/ui/pages/notifications_page.dart';
import 'package:al_khabeer/features/students/data/response/students_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/accounts/bloc/account_by_id_cubit/account_by_id_cubit.dart';
import '../features/accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../features/accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../features/accounts/data/request/account_request.dart';
import '../features/audit/ui/pages/audit_page.dart';
import '../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/logout/logout_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';
import '../features/cash_account/ui/pages/cash_account_page.dart';
import '../features/debit/ui/pages/debit_page.dart';
import '../features/demo/ui/pages/demo.dart';
import '../features/employees/ui/pages/employees_page.dart';
import '../features/exam_table/bloc/exam_cubit/exam_cubit.dart';
import '../features/exam_table/ui/pages/exam_table_page.dart';
import '../features/home/bloc/slider_cubit/slider_cubit.dart';
import '../features/home/ui/pages/contact_page.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/inventory/bloc/inventory_cubit/inventory_cubit.dart';
import '../features/inventory/ui/pages/inventory_list_page.dart';
import '../features/inventory/ui/pages/inventory_page.dart';
import '../features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../features/policy/ui/pages/policy.dart';
import '../features/student_transactions/bloc/student_transactions_cubit/student_transactions_cubit.dart';
import '../features/student_transactions/data/request/student_transactions_request.dart';
import '../features/students/ui/pages/student_info_page.dart';
import '../features/students/ui/pages/students_list_page.dart';
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

      //endregion

      //region home
      case RouteName.home:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<SliderCubit>()..getSlider(_)),
          BlocProvider(create: (_) => di.sl<LogoutCubit>()),
          BlocProvider(create: (_) => di.sl<DeleteAccountCubit>()),
          BlocProvider(create: (_) => di.sl<NotificationCountCubit>()),
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
          BlocProvider(create: (_) => di.sl<ExamCubit>()),
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
        return CupertinoPageRoute(
          builder: (context) {
            return const StudentsPage();
          },
        );
      //endregion
      case RouteName.studentsList:
        //region
        return CupertinoPageRoute(
          builder: (context) {
            return StudentsListPage(
              result: settings.arguments == null
                  ? <Student>[]
                  : settings.arguments as List<Student>,
            );
          },
        );
      //endregion

      case RouteName.debit:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<AccountByIdCubit>()),
          BlocProvider(
            create: (_) => di.sl<AccountsCubit>()
              ..getAccounts(
                _,
                request: AccountRequest(
                  type: 'expenses',
                ),
              ),
          ),
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
          BlocProvider(create: (_) => di.sl<AccountByIdCubit>()),
          BlocProvider(
            create: (_) => di.sl<AccountsCubit>()
              ..getAccounts(
                _,
                request: AccountRequest(
                  type: 'revenues',
                ),
              ),
          ),
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

        final student = settings.arguments as Student;
        // final providers = [
        //   BlocProvider(
        //     create: (_) => di.sl<StudentTransactionsCubit>()
        //       ..getStudentTransactions(
        //         _,
        //         request: StudentTransactionsRequest(studentguid: studentGuid),
        //       ),
        //   ),
        // ];
        return CupertinoPageRoute(
          builder: (context) {
            return StudentInfoPage(student: student);
          },
        );
      //endregion

      case RouteName.cashAccount:
        //region

        final providers = [
          BlocProvider(create: (_) => di.sl<AccountByIdCubit>()),
          BlocProvider(
            create: (_) => di.sl<AccountsCubit>()
              ..getAccounts(
                _,
                request: AccountRequest(
                  type: 'ready',
                ),
              ),
          ),
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

      // case RouteName.notifications:
      //   //region
      //
      //   final providers = [
      //     BlocProvider(create: (_) => di.sl<NotificationsCubit>()..getNotifications(_)),
      //   ];
      //   return CupertinoPageRoute(
      //     builder: (context) {
      //       return MultiBlocProvider(
      //         providers: providers,
      //         child: const NotificationsPage(),
      //       );
      //     },
      //   );
      // //endregion

      case RouteName.demo:
        //region

        return CupertinoPageRoute(
          builder: (context) {
            return const DemoPage();
          },
        );
      //endregion

      //endregion
      case RouteName.policy:
        //region

        return CupertinoPageRoute(
          builder: (context) {
            return const PolicyPage();
          },
        );
      //endregion

      //endregion

      //region inventory

      case RouteName.inventory:
        //region
        final providers = [
          BlocProvider(
            create: (context) => di.sl<InventoryCubit>(),
          ),
        ];
        return CupertinoPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: const InventoryPage(),
          );
        });

      //endregion
      case RouteName.inventoryList:
        //region

        return CupertinoPageRoute(builder: (context) {
          return InventoryListPage(state: settings.arguments as InventoryInitial);
        });

      //endregion

      case RouteName.contact:
        //region

        return CupertinoPageRoute(builder: (context) {
          return const ContactPage();
        });

      //endregion

      //endregion
    }

    return CupertinoPageRoute(
        builder: (_) => const Scaffold(backgroundColor: Colors.red));
  }
}

class RouteName {
  static const splash = '/';

  static const home = '/2';

  static const login = '/5';

  static const searchResult = '/11';
  static const update = '/12';
  static const updateChoice = '/13';

  // static const notifications = '/14';
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
  static const studentsList = '/30';
  static const inventoryList = '/31';
  static const contact = '/32';
}
