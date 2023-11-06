import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/core/widgets/my_text_form_widget.dart';
import 'package:al_khabeer/generated/assets.dart';
import 'package:al_khabeer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../data/request/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final request = LoginRequest();

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
      },
      child: Scaffold(
        appBar: const AppBarWidget(zeroHeight: true),
        body: SizedBox(
          width: 1.0.sw,
          height: 1.0.sh,
          child: SingleChildScrollView(
            padding: MyStyle.authPagesPadding,
            child: Column(
              children: [
                140.verticalSpace,
                ImageMultiType(
                  url: Assets.iconsLogoWithoutText,
                  height: 165.0.r,
                  width: 165.0.r,
                ),
                50.0.verticalSpace,
                MyTextFormOutLineWidget(
                  textDirection: TextDirection.ltr,
                  initialValue: request.username,
                  label: S.of(context).userName,
                  onChanged: (val) => request.username = val,
                ),
                20.0.verticalSpace,
                MyTextFormOutLineWidget(
                  label: S.of(context).password,
                  obscureText: true,
                  onChanged: (val) => request.password = val,
                  textDirection: TextDirection.ltr,
                ),
                30.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    //تسجيل الدخول
                    return MyButton(
                      text: S.of(context).login,
                      onTap: () {
                        context.read<LoginCubit>().login(context, request: request);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
