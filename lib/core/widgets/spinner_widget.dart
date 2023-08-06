import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:al_khabeer/core/strings/enum_manager.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({
    Key? key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;

  @override
  Widget build(BuildContext context) {
    SpinnerItem? selectedItem;

    final list = items.map(
      (item) {
        if (item.isSelected) selectedItem = item;

        return DropdownMenuItem(
          value: item,
          child: DrawableText(
            text: item.name ?? '',
            padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
            color: (item.id != 0) ? Colors.white : AppColorManager.gray.withOpacity(0.7),
            fontFamily: FontManager.cairoBold,
            size: 18.0.sp,
          ),
        );
      },
    ).toList();

    selectedItem ??= items.isEmpty ? null : items[0];

    return StatefulBuilder(
      builder: (_, state) {
        return DropdownButton2(
          items: list,
          value: hint != null ? null : selectedItem,
          hint: hint,
          onChanged: (value) {
            if (onChanged != null) onChanged!(value!);
            state(() => selectedItem = value!);
          },
          buttonWidth: width,
          buttonHeight: 60.0.h,
          dropdownWidth: dropdownWidth,
          customButton: customButton,
          underline: 0.0.verticalSpace,
          dropdownMaxHeight: 300.0.h,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            color: AppColorManager.mainColorLight,
          ),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            color: AppColorManager.mainColor,
          ),
          buttonPadding: EdgeInsets.symmetric(horizontal: 20.0).w,
          buttonElevation: 0,
          dropdownElevation: 2,
          iconEnabledColor: Colors.white,
          iconDisabledColor: Colors.white,
          iconSize: 30.0.r,
          // icon: const Icon(Icons.arrow_drop_down_outlined),
          // iconSize: 20.0.spMin,
        );
      },
    );
  }
}

class SpinnerItem {
  SpinnerItem({
    this.name,
    this.id,
    this.isSelected = false,
    this.item,
    this.enable,
  });

  String? name;
  int? id;
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
