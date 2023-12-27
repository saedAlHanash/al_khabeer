import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class SpinnerWidget<T> extends StatelessWidget {
  const SpinnerWidget({
    Key? key,
    required this.items,
    this.hint,
    this.hintText,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sedFirstItem,
    this.expanded,
    this.decoration,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final Widget? hint;
  final String? hintText;
  final Widget? customButton;
  final Function(SpinnerItem item)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sedFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    SpinnerItem? selectedItem;

    final list = items.map(
      (item) {
        if (item.isSelected) selectedItem = item;

        return DropdownMenuItem(
          value: item,
          enabled: (item.id ?? 0) > 0,
          child: DrawableText(
            selectable: false,
            text: item.name ?? '',
            color: (item.id != 0) ? Colors.white : AppColorManager.mainColorLight,
            size: 20.0.sp,
            fontFamily: FontManager.cairoBold.name,
            drawableStart: item.icon,
            drawablePadding: 7.0.w,
          ),
        );
      },
    ).toList();

    // if (hint == null) selectedItem ??= items.firstOrNull;

    if ((sedFirstItem ?? false) && selectedItem != null) {
      if (onChanged != null) onChanged!(selectedItem!);
    }

    return Column(
      children: [
        if (hintText != null)
          DrawableText(
            text: hintText!,
            color: AppColorManager.newsHeader,
            size: 20.0.sp,
            fontFamily: FontManager.cairoBold.name,
            matchParent: true,
            padding: const EdgeInsets.symmetric(horizontal: 5.0).w,
          ),
        if (hintText != null) 15.0.verticalSpace,
        StatefulBuilder(
          builder: (_, state) {
            return DropdownButton2(
              items: list,
              value: selectedItem,
              hint: hint,
              onChanged: (value) {
                if (onChanged != null) onChanged!(value!);
                state(() => selectedItem = value!);
              },
              buttonWidth: 1.0.sw,
              isExpanded: expanded ?? false,
              dropdownWidth: dropdownWidth,
              customButton: customButton,
              underline: 0.0.verticalSpace,
              buttonHeight: 50.0.h,
              dropdownMaxHeight: 300.0.h,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.mainColorLight,
              ),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.mainColor,
              ),
              buttonPadding: const EdgeInsets.symmetric(horizontal: 20.0).w,
              buttonElevation: 0,
              dropdownElevation: 2,
              icon: Row(
                children: [
                  const Icon(
                    Icons.expand_more,
                    color: AppColorManager.whit,
                  ),
                  5.0.horizontalSpace,
                ],
              ),
              iconSize: 25.0.spMin,
            );
          },
        ),
      ],
    );
  }
}

class SpinnerItem {
  SpinnerItem({
    this.name,
    this.id,
    this.guid,
    this.isSelected = false,
    this.item,
    this.icon,
    this.enable,
  });

  String? name;
  int? id;
  Widget? icon;
  String? guid;
  bool isSelected;
  bool? enable;
  dynamic item;

//<editor-fold desc="Data Methods">

  SpinnerItem copyWith({
    String? name,
    int? id,
    bool? isSelected,
    bool? enable,
    dynamic item,
  }) {
    return SpinnerItem(
      name: name ?? this.name,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      enable: enable ?? this.enable,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'isSelected': isSelected,
      'enable': enable,
      'item': item,
    };
  }

  factory SpinnerItem.fromMap(Map<String, dynamic> map) {
    return SpinnerItem(
      name: map['name'] as String,
      id: map['id'] as int,
      isSelected: map['isSelected'] as bool,
      enable: map['enable'] as bool,
      item: map['item'] as dynamic,
    );
  }

//</editor-fold>
}
