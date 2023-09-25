import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/my_button.dart';
import 'package:al_khabeer/generated/assets.dart';
import 'package:al_khabeer/router/app_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_khabeer/core/util/shared_preferences.dart';
import 'package:al_khabeer/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/bottom_nav_widget.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';

import '../../../news/ui/pages/news_page.dart';
import '../../../students/ui/pages/students_page.dart';
import '../widget/screens/home_screen.dart';

import '../../../notifications/ui/pages/notifications_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartInitial>(
      listenWhen: (p, c) => c.goToCart,
      listener: (context, state) {
        pageIndex = 1;
        setState(() => _pageController.jumpToPage(1));
      },
      child: WillPopScope(
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
            title: ImageMultiType(
              url: Assets.iconsLogoWithoutText,
              height: 60.0.r,
              width: 60.0.r,
            ),
            actions: [],
          ),
          drawer: SafeArea(
            child: Drawer(
              width: 208.0.w,
              backgroundColor: AppColorManager.mainColor.withOpacity(0.6),
              elevation: 0.01,
              shadowColor: Colors.transparent,
              child: Column(
                children: [
                  80.0.verticalSpace,
                  ImageMultiType(
                    url: Assets.iconsLogoWithoutText,
                    height: 80.0.r,
                    width: 80.0.r,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: 'Admin Name',
                    size: 20.0.spMin,
                    color: AppColorManager.whit,
                    fontFamily: FontManager.cairoBold,
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
                      text: 'اختيار اللغة',
                      color: Colors.white,
                    ),
                    minLeadingWidth: 5.0.r,
                    onTap: () {
                      NoteMessage.showMyDialog(
                        context,
                        child: LanWidget(),
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
                      text: 'سياسة الخصوصية والأحكام',
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
                  Spacer(),
                  MyButton(
                    width: 170.0.w,
                    color: AppColorManager.mainColorDark,
                    child: DrawableText(
                      text: 'logout',
                      color: Colors.white,
                      drawableAlin: DrawableAlin.between,
                      textAlign: TextAlign.center,
                      matchParent: true,
                      drawableStart: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NewNav(
            onChange: (index) {
              pageIndex = index;
              setState(() => _pageController.jumpToPage(index));
            },
            controller: _pageController,
          ),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                StudentsPage(withAppBar: false),
                NotificationsScreen(),
                NewsPage(),
              ],
            ),
          ),
        ),
      ),
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
  Widget build(BuildContext context) {
    return Container(
      height: 250.0.h,
      width: 300.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawableText(
            text: 'اللغة',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => select = 0),
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: select == 0 ? Colors.lightBlue : Colors.white,
                  ),
                  child: Column(
                    children: [
                      DrawableText(
                        text: 'English',
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColorManager.mainColorLight),
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: DrawableText(text: 'EN'),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => select = 1),
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColorManager.mainColorLight),
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: select != 0 ? Colors.lightBlue : Colors.white,
                  ),
                  child: Column(
                    children: [
                      DrawableText(
                        text: 'العربية',
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorManager.lightGray,
                        ),
                        child: DrawableText(text: 'ع'),
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
