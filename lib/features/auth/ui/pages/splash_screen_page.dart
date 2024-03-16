import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {


    Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.pushReplacementNamed(
        context,
        AppSharedPreference.isLogin ? RouteName.home : RouteName.login,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        height: 1.0.sh,
        padding: MyStyle.authPagesPadding,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageMultiType(
                height: 208.0.r,
                width: 241.0.r,
                url: Assets.iconsLogoSplash,
              ),
              115.0.verticalSpace,
              DrawableText(
                text: 'www.khsites.com',
                color: Color(0xFF0A5EAA),
                size:23.0.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
