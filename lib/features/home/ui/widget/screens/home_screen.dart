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
    return SingleChildScrollView(
padding: EdgeInsets.symmetric(horizontal: 30.0).w,
      child: Column(

        children: [
          20.0.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemCardWidget(item: HomeCards.students),
              30.0.horizontalSpace,
              ItemCardWidget(item: HomeCards.cashPayment),
            ],
          ),
          30.0.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemCardWidget(item: HomeCards.inventory),
              30.0.horizontalSpace,
              ItemCardWidget(item: HomeCards.examTable),
            ],
          ),
          30.0.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemCardWidget(item: HomeCards.audit),
              30.0.horizontalSpace,
              ItemCardWidget(item: HomeCards.debit),
            ],
          ),
          30.0.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemCardWidget(item: HomeCards.teachers),
              30.0.horizontalSpace,
              ItemCardWidget(item: HomeCards.employees),
            ],
          ),
          30.0.verticalSpace,
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          switch (widget.item) {
            case HomeCards.students:
              {
                Navigator.pushNamed(context, RouteName.students);
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
                Navigator.pushNamed(context, RouteName.audit);
                break;
              }
            case HomeCards.debit:
              {
                Navigator.pushNamed(context, RouteName.debit);
                break;
              }
            case HomeCards.teachers:
              {
                Navigator.pushNamed(context, RouteName.teachers);
                break;
              }
            case HomeCards.employees:
              {
                Navigator.pushNamed(context, RouteName.employees);
                break;
              }
          }
        },
        child: MyCardWidget(
            elevation: 0.0,
            margin: EdgeInsets.zero,
            child: SizedBox(
              height: 120.0.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageMultiType(
                    url: widget.item.icon,
                    height: 65.0.r,
                    width: 65.0.r,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: widget.item.arabicName,
                    color: AppColorManager.mainColorDark,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                ],
              ),
            )),
      ),
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
