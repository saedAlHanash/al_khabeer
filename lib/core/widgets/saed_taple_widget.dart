import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/widgets/spinner_widget.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api_manager/request_models/command.dart';
import 'my_card_widget.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget(
      {super.key,
      required this.title,
      required this.data,
      this.command,
      this.onChangePage,
      this.fullSizeIndex,
      this.onTapItem});

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final List<List<dynamic>> data;

  final Command? command;

  final Function(Command command)? onChangePage;
  final Function(List<dynamic> list, int i)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20.0).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0.r)),
                color: AppColorManager.tableTitle),
            child: Row(
              children: title.mapIndexed(
                (i, e) {
                  final widget = e is String
                      ? DrawableText(
                          size: 16.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: e,
                          color: AppColorManager.tableTitleText,
                          fontFamily: FontManager.cairoBold,
                        )
                      : title is Widget
                          ? title as Widget
                          : Container(
                              color: Colors.red,
                              height: 10,
                            );

                  return Expanded(child: widget);
                },
              ).toList(),
            ),
          ),

          ...data.mapIndexed((i1, e) {
            return InkWell(
              onTap: onTapItem == null ? null : () => onTapItem?.call(e, i1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
                margin: EdgeInsets.symmetric(vertical: 3.0).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0.r),
                  color: AppColorManager.tableTitleItem,
                ),
                child: Row(
                  children: e.mapIndexed(
                    (i, e) {
                      final widget = e is String
                          ? Directionality(
                              textDirection: e.contains('spy')
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: DrawableText(
                                size: 16.0.sp,
                                matchParent: !(fullSizeIndex?.contains(i) ?? true),
                                textAlign: TextAlign.center,
                                text: e.isEmpty ? '-' : e.replaceAll('spy', ''),
                                color: Colors.black,
                              ),
                            )
                          : e is Widget
                              ? e
                              : Container(
                                  height: 10,
                                  color: Colors.red,
                                );

                      if (fullSizeIndex?.contains(i) ?? false) {
                        return widget;
                      }

                      return Expanded(child: widget);
                    },
                  ).toList(),
                ),
              ),
            );
          }).toList(),
          // if (command != null)
          //   SpinnerWidget(
          //     items: command!.getSpinnerItems,
          //     onChanged: (spinnerItem) {
          //       onChangePage?.call(command!..goToPage(spinnerItem.id));
          //     },
          //   ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}

class SaedTableWidget1 extends StatelessWidget {
  const SaedTableWidget1(
      {super.key,
      required this.title,
      required this.data,
      this.command,
      this.onChangePage,
      this.fullSizeIndex});

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final List<List<dynamic>> data;

  final Command? command;

  final Function(Command command)? onChangePage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50.0.h,
            child: IntrinsicHeight(
              child: Row(
                children: title.mapIndexed(
                  (i, e) {
                    final widget = e is String
                        ? DrawableText(
                            size: 16.0.sp,
                            matchParent: true,
                            textAlign: TextAlign.center,
                            text: e,
                            color: AppColorManager.mainColorDark,
                            fontFamily: FontManager.cairoBold,
                          )
                        : title is Widget
                            ? title as Widget
                            : Container(
                                color: Colors.red,
                                height: 10,
                              );

                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(child: widget),
                          if (i != title.length - 1)
                            Container(
                              margin: EdgeInsets.only(top: 15.0).h,
                              width: 1.0.h,
                              color: AppColorManager.lightGrayEd,
                            ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Divider(
            height: 0.0,
            indent: 0.0,
            endIndent: 0.0,
            color: AppColorManager.lightGrayEd,
          ),
          ...data.mapIndexed((i1, e) {
            var key = GlobalKey();
            return Column(
              children: [
                Container(
                  key: key,
                  child: Row(
                    children: e.mapIndexed(
                      (i, e) {
                        final widget = e is String
                            ? Directionality(
                                textDirection: e.contains('spy')
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: DrawableText(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  size: 16.0.sp,
                                  matchParent: !(fullSizeIndex?.contains(i) ?? true),
                                  textAlign: TextAlign.center,
                                  text: e.isEmpty ? '-' : e.replaceAll('spy', ''),
                                  color: Colors.black,
                                ),
                              )
                            : e is Widget
                                ? e
                                : Container(
                                    height: 10,
                                    color: Colors.red,
                                  );

                        if (fullSizeIndex?.contains(i) ?? false) {
                          return widget;
                        }

                        return Expanded(
                          child: Row(
                            children: [
                              Expanded(child: widget),
                              if (i != title.length - 1)
                                FutureBuilder(
                                  future: Future.delayed(Duration(milliseconds: 50), () {
                                    return key.currentContext?.size;
                                  }),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return 0.0.verticalSpace;
                                    print(snapshot.requireData);
                                    return Container(
                                      width: 1.0.w,
                                      height: snapshot.requireData?.height,
                                      color: AppColorManager.lightGrayEd,
                                    );
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                if (i1 != data.length - 1)
                  Divider(
                    height: 0.0,
                    indent: 0.0,
                    endIndent: 0.0,
                    color: AppColorManager.lightGrayEd,
                  ),
              ],
            );
          }).toList(),
          // if (command != null)
          //   SpinnerWidget(
          //     items: command!.getSpinnerItems,
          //     onChanged: (spinnerItem) {
          //       onChangePage?.call(command!..goToPage(spinnerItem.id));
          //     },
          //   ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
