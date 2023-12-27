import 'package:al_khabeer/core/app/app_widget.dart';
import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/util/shared_preferences.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/generated/assets.dart';
import 'package:al_khabeer/router/app_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/bottom_nav_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../news/ui/pages/news_page.dart';
import '../../../notifications/ui/pages/notifications_screen.dart';
import '../../../students/ui/pages/students_page.dart';
import '../widget/screens/home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var pageIndex = 0;

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageIndex != 0) {
          pageIndex = 0;
          setState(() => _pageController.jumpToPage(0));
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: DrawableText(
            text: NavItems.values[pageIndex].arabicName,
            size: 24.0.sp,
            fontFamily: FontManager.cairoBold.name,
          ),
          actions: [
            30.0.horizontalSpace,
            ImageMultiType(
              url: Assets.iconsLogoWithoutText,
              height: 45.0.r,
              width: 45.0.r,
            ),
            30.0.horizontalSpace,
          ],
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const ImageMultiType(url: Assets.iconsMenueIcon),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
        ),
        bottomNavigationBar: NewNav(
          onChange: (index) {
            pageIndex = index;
            setState(() => _pageController.jumpToPage(index));
          },
          controller: _pageController,
        ),
        drawer: SafeArea(
          child: Drawer(
            width: 280.0.w,
            backgroundColor: AppColorManager.mainColor.withOpacity(0.6),
            elevation: 0.01,
            shadowColor: Colors.transparent,
            child: Column(
              children: [
                20.0.verticalSpace,
                ImageMultiType(
                  url: Assets.iconsLogoWithoutText,
                  height: 80.0.r,
                  width: 80.0.r,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: AppSharedPreference.getUserModel().name,
                  size: 20.0.spMin,
                  color: AppColorManager.whit,
                  fontFamily: FontManager.cairoBold.name,
                ),
                DrawableText(
                  text: AppSharedPreference.getUserModel().school.name,
                  size: 20.0.spMin,
                  color: AppColorManager.whit,
                  fontFamily: FontManager.cairoBold.name,
                ),
                Divider(
                  thickness: 2.0.r,
                  endIndent: 0.0,
                  indent: 0.0,
                ),
                // ListTile(
                //   title: DrawableText(
                //     text: 'عن الديمو',
                //     color: Colors.white,
                //   ),
                //   minLeadingWidth: 5.0.r,
                //   onTap: () {
                //     Navigator.pushNamed(context, RouteName.demo);
                //   },
                //   leading: ImageMultiType(
                //     url: Assets.iconsInfo,
                //     height: 20.0.r,
                //     width: 20.0.r,
                //   ),
                // ),

                ListTile(
                  title: DrawableText(
                    text: S.of(context).choseLanguage,
                    color: Colors.white,
                  ),
                  minLeadingWidth: 5.0.r,
                  onTap: () {
                    Navigator.pop(context);
                    NoteMessage.showMyDialog(
                      context,
                      child: const LanWidget(),
                      onCancel: (v) {
                        if (v == null) return;
                        Future.delayed(
                          const Duration(microseconds: 500),
                          () => MyApp.setLocale(context, Locale(v == 0 ? 'en' : 'ar')),
                        );
                      },
                    );
                  },
                  leading: ImageMultiType(
                    url: Assets.iconsLang,
                    height: 20.0.r,
                    width: 20.0.r,
                  ),
                ),
                ListTile(
                  title: DrawableText(
                    text: S.of(context).policy,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.policy);
                  },
                  minLeadingWidth: 5.0.r,
                  leading: ImageMultiType(
                    url: Assets.iconsShiled,
                    height: 20.0.r,
                    width: 20.0.r,
                  ),
                ),
                const Spacer(),
                MyButton(
                  width: 170.0.w,
                  color: AppColorManager.mainColorDark,
                  onTap: () => showLogoutDialog(context),
                  child: DrawableText(
                    text: S.of(context).logout,
                    color: Colors.white,
                    drawableAlin: DrawableAlin.between,
                    textAlign: TextAlign.center,
                    matchParent: true,
                    drawableStart: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
                40.0.verticalSpace,
              ],
            ),
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              StudentsPage(withAppBar: false),
              NotificationsScreen(),
              NewsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).logout),
      content: Text(S.of(context).confirmLogout),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text(S.of(context).logout),
          onPressed: () {
            AppSharedPreference.logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.splash,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}

class LanWidget extends StatefulWidget {
  const LanWidget({super.key});

  @override
  State<LanWidget> createState() => _LanWidgetState();
}

class _LanWidgetState extends State<LanWidget> {
  var select = 0;

  @override
  void initState() {
    select = AppSharedPreference.getLocal != 'ar' ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0.h,
      width: 300.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawableText(
            color: const Color(0xFF333333),
            size: 18.0.sp,
            padding: const EdgeInsets.symmetric(vertical: 30.0).h,
            fontFamily: FontManager.cairoBold.name,
            text: S.of(context).language,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => select = 0);
                  Navigator.pop(context, select);
                },
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r),
                    border:
                        select == 0 ? null : Border.all(color: const Color(0xFFE8F3F1)),
                    color: select == 0 ? AppColorManager.mainColorDark : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: DrawableText(
                          text: 'EN',
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      6.0.verticalSpace,
                      DrawableText(
                        text: 'English',
                        color:
                            select == 0 ? AppColorManager.whit : const Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => select = 1);
                  Navigator.pop(context, select);
                },
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    border:
                        select == 1 ? null : Border.all(color: const Color(0xFFE8F3F1)),
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: select != 0 ? AppColorManager.mainColorDark : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorManager.lightGray,
                        ),
                        child: DrawableText(
                          text: 'ع',
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      DrawableText(
                        text: 'العربية',
                        color:
                            select == 1 ? AppColorManager.whit : const Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
