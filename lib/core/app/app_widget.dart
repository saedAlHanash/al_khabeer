import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/accounts/bloc/accounts_cubit/accounts_cubit.dart';
import '../../features/accounts/bloc/transactions_cubit/transactions_cubit.dart';
import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/employees/bloc/employees_cubit/employees_cubit.dart';
import '../../features/filter_data/bloc/class_cubit/class_cubit.dart';
import '../../features/filter_data/bloc/class_level_cubit/class_level_cubit.dart';
import '../../features/filter_data/bloc/group_cubit/group_cubit.dart';
import '../../features/filter_data/bloc/material_cubit/material_cubit.dart';
import '../../features/filter_data/bloc/stage_cubit/stage_cubit.dart';
import '../../features/news/bloc/news_cubit/news_cubit.dart';
import '../../features/students/bloc/student_cubit/student_cubit.dart';
import '../../features/teachers/bloc/teachers_cubit/teachers_cubit.dart';
import '../../router/app_router.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart' as di;
import 'bloc/loading_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Builder(builder: (_) {
      return Visibility(
        visible: context.watch<LoadingCubit>().state.isLoading,
        child: SafeArea(
          child: Column(
            children: [
              const LinearProgressIndicator(),
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return ScreenUtilInit(
      designSize: const Size(412, 770),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          headerSizeText: 18.0.spMin,
          initialHeightText: 1.8.spMin,
          titleSizeText: 15.0.spMin,
          initialSize: 16.0.spMin,
          renderHtml: false,
          selectable: false,
          initialColor: AppColorManager.mainColorDark,
        );

        return MaterialApp(
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => di.sl<LoadingCubit>()),
                BlocProvider(create: (_) => di.sl<AddToCartCubit>()),
                BlocProvider(create: (_) => di.sl<StageCubit>()..getStage(_)),
                BlocProvider(create: (_) => di.sl<NewsCubit>()..getNews(_)),
                BlocProvider(create: (_) => di.sl<ClassCubit>()..getClass(_)),
                BlocProvider(create: (_) => di.sl<GroupCubit>()..getGroups(_)),
                BlocProvider(create: (_) => di.sl<StudentCubit>()..getStudent(_)),
                BlocProvider(create: (_) => di.sl<TeachersCubit>()..getTeachers(_)),
                BlocProvider(create: (_) => di.sl<EmployeesCubit>()..getEmployees(_)),
                BlocProvider(create: (_) => di.sl<ClassLevelCubit>()..getClassLevel(_)),
                BlocProvider(create: (_) => di.sl<AccountsCubit>()..getAccounts(_)),
                BlocProvider(
                  create: (_) => di.sl<TransactionsCubit>()..getTransactions(_),
                ),
                BlocProvider(
                  create: (_) => di.sl<MaterialCubit>()..getMaterials(_, groupGuid: null),
                ),
              ],
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [child!, loading],
                ),
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          onGenerateRoute: AppRoutes.routes,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
