import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/strings/enum_manager.dart';
import 'package:al_khabeer/core/widgets/my_card_widget.dart';
import 'package:al_khabeer/generated/assets.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../../router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GridView(
        padding: EdgeInsets.symmetric(horizontal: 10.0).w,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 155.0.h),
        children: [
          ItemCardWidget(item: HomeCards.students),
          ItemCardWidget(item: HomeCards.cashPayment),
          ItemCardWidget(item: HomeCards.inventory),
          ItemCardWidget(item: HomeCards.examTable),
          ItemCardWidget(item: HomeCards.audit),
          ItemCardWidget(item: HomeCards.debit),
          ItemCardWidget(item: HomeCards.teachers),
          ItemCardWidget(item: HomeCards.employees),
        ],
      ),
    );
  }
}

class ItemCardWidget extends StatefulWidget {
  const ItemCardWidget({super.key, required this.item});

  final HomeCards item;

  @override
  State<ItemCardWidget> createState() => _ItemCardWidgetState();
}

class _ItemCardWidgetState extends State<ItemCardWidget> {
  late final String icon;
  late final String text;

  @override
  void initState() {
    text = widget.item.arabicName;
    icon = widget.item.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (widget.item) {
          case HomeCards.students:
            {
              break;
            }
          case HomeCards.cashPayment:
            {
              Navigator.pushNamed(context, RouteName.cashAccount);
              break;
            }
          case HomeCards.inventory:
            {
              Navigator.pushNamed(context, RouteName.inventory);
              break;
            }
          case HomeCards.examTable:
            {
              Navigator.pushNamed(context, RouteName.examTable);
              break;
            }
          case HomeCards.audit:
            {
              break;
            }
          case HomeCards.debit:
            {
              break;
            }
          case HomeCards.teachers:
            {
              break;
            }
          case HomeCards.employees:
            {
              break;
            }
        }
      },
      child: MyCardWidget(
          cardColor: AppColorManager.textFieldColor,
          elevation: 0.0,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.all(10.0).r,
          child: SizedBox(
            height: 152.0.h,
            width: 170.0.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageMultiType(
                  url: icon,
                  height: 70.0.r,
                  width: 70.0.r,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: text,
                  color: AppColorManager.mainColorDark,
                  fontFamily: FontManager.cairoBold,
                ),
              ],
            ),
          )),
    );
  }
}

class StrikeThroughWidget extends StatelessWidget {
  const StrikeThroughWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        ImageMultiType(
          url: Assets.iconsDMRMq,
          fit: BoxFit.fitWidth,
          width: 70.0.w,
        ),
      ],
    );
  }
}
