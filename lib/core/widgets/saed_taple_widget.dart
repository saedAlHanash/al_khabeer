import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api_manager/request_models/command.dart';
import '../util/pair_class.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0.r)),
                color: AppColorManager.tableTitle),
            child: Row(
              children: title.mapIndexed(
                (i, e) {
                  final widget = e is String
                      ? DrawableText(
                    maxLines: 1,
                          size: 13.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: e,
                          color: AppColorManager.textColor1,
                          fontFamily: FontManager.cairoBold.name,
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
                margin: const EdgeInsets.symmetric(vertical: 3.0).r,
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
                                maxLines: 1,
                                size: 12.0.sp,
                                matchParent: !(fullSizeIndex?.contains(i) ?? true),
                                textAlign: TextAlign.center,
                                text: e.isEmpty ? '-' : e.replaceAll('spy', ''),
                                color: AppColorManager.textColor1,
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
      // padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50.0.h,
            child: IntrinsicHeight(
              child: Row(
                children: title.mapIndexed(
                  (i, e) {
                    final widget = e is String
                        ? DrawableText(
                      maxLines: 1,
                            size: 15.0.sp,
                            matchParent: true,
                            textAlign: TextAlign.center,
                            text: e,
                            color: AppColorManager.newsHeader,
                            fontFamily: FontManager.cairoBold.name,
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
                              margin: const EdgeInsets.only(top: 15.0).h,
                              width: 1.0.w,
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
          const Divider(
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
                        final widget = e is TableItem
                            ? DrawableText(
                          maxLines: 1,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                size: 15.0.sp,
                                matchParent: !(fullSizeIndex?.contains(i) ?? true),
                                textAlign: TextAlign.center,
                                text: e.data.isEmpty ? '-' : e.data,
                                color: e.background,
                                fontFamily: e.background != null
                                    ? FontManager.cairoBold.name
                                    : FontManager.cairo.name,
                              )
                            : e is String
                                ? Directionality(
                                    textDirection: e.contains('spy')
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    child: DrawableText(
                                      maxLines: 1,
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      size: 15.0.sp,
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
                                  future: Future.delayed(const Duration(milliseconds: 50),
                                      () {
                                    return key.currentContext?.size;
                                  }),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return 0.0.verticalSpace;
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
                  const Divider(
                    height: 0.0,
                    indent: 0.0,
                    endIndent: 0.0,
                    color: AppColorManager.lightGrayEd,
                  ),
              ],
            );
          }).toList(),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}

class TableItem {
  final String data;
  final Color? background;

  const TableItem({
    required this.data,
    required this.background,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableItem &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          background == other.background);

  @override
  int get hashCode => data.hashCode ^ background.hashCode;

  @override
  String toString() {
    return 'TableItem{' + ' data: $data,' + ' background: $background,' + '}';
  }

  TableItem copyWith({
    String? data,
    Color? background,
  }) {
    return TableItem(
      data: data ?? this.data,
      background: background ?? this.background,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
      'background': this.background,
    };
  }

  factory TableItem.fromMap(Map<String, dynamic> map) {
    return TableItem(
      data: map['data'] as String,
      background: map['background'] as Color,
    );
  }

//</editor-fold>
}

class Table2Item extends StatelessWidget {
  const Table2Item({super.key, required this.title, required this.data});

  final List<String> title;
  final List<Pair<TableItem, TableItem>> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.0.h,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: DrawableText(
                      maxLines: 1,
                      size: 18.0.sp,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      text: title.first,
                      color: AppColorManager.newsHeader,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0).h,
                    width: 1.0.w,
                    color: AppColorManager.lightGrayEd,
                  ),
                  Expanded(
                    child: DrawableText(
                      maxLines: 1,
                      size: 18.0.sp,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      text: title.last,
                      color: AppColorManager.newsHeader,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 0.0,
            endIndent: 0.0,
            color: AppColorManager.lightGrayEd,
          ),
          for (var e in data)
            Column(
              children: [
                20.0.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200.0.w,
                      child: DrawableText(
                        maxLines: 1,
                        size: 18.0.sp,
                        textAlign: TextAlign.start,
                        text: e.first.data.isEmpty ? '-' : e.first.data,
                        matchParent: true,
                        color: AppColorManager.newsHeader,
                        fontFamily: e.first.background != null
                            ? FontManager.cairoBold.name
                            : FontManager.cairo.name,
                      ),
                    ),
                    Container(
                      width: 82.0.w,
                      margin: EdgeInsetsDirectional.only(end: 20.0.w),
                      child: DrawableText(
                        maxLines: 1,
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.end,
                        text: e.second.data.isEmpty ? '-' : e.second.data,
                        color: AppColorManager.newsHeader,
                        fontFamily: FontManager.cairoBold.name,
                      ),
                    )
                  ],
                ),
                20.0.verticalSpace,
                const Divider(
                  height: 0.0,
                  indent: 0.0,
                  endIndent: 0.0,
                  color: AppColorManager.lightGrayEd,
                ),
              ],
            ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}

class Table3Item extends StatelessWidget {
  const Table3Item({
    super.key,
    required this.title,
    required this.data,
    this.onTapItem,
  });

  final List<String> title;
  final List<List<String>> data;
  final Function(List<dynamic> list, int i)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0.r)),
                color: AppColorManager.tableTitle),
            child: Row(
              children: title.mapIndexed(
                (i, e) {
                  final widget = DrawableText(
                    maxLines: 1,
                    size: 20.0.sp,
                    matchParent: true,
                    textAlign: TextAlign.center,
                    text: e,
                    color: AppColorManager.newsHeader,
                  );

                  return Expanded(child: widget);
                },
              ).toList(),
            ),
          ),
          ...data.mapIndexed((i, e) {
            return InkWell(
              onTap: onTapItem == null ? null : () => onTapItem?.call(e, i),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DrawableText(
                      maxLines: 1,
                      size: 18.0.sp,
                      textAlign: TextAlign.center,
                      text: e[0],
                      color: AppColorManager.newsHeader,
                    ),
                  ),
                  Container(
                    width: 1.0.w,
                    height: 54.0.h,
                    color: Color(0xFFD1D1D1),
                  ),
                  Expanded(
                    child: DrawableText(
                      maxLines: 1,
                      size: 18.0.sp,
                      textAlign: TextAlign.center,
                      text: e[1],
                      color: AppColorManager.newsHeader,
                    ),
                  ),
                  Container(
                    width: 1.0.w,
                    height: 54.0.h,
                    color: Color(0xFFD1D1D1),
                  ),
                  Expanded(
                    child: DrawableText(
                      maxLines: 1,
                      size: 18.0.sp,
                      textAlign: TextAlign.center,
                      text: e[2],
                      color: AppColorManager.newsHeader,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
