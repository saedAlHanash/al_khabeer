import 'dart:convert';

import 'package:al_khabeer/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../strings/app_string_manager.dart';
import '../strings/enum_manager.dart';
import 'package:http/http.dart' as http;

import '../util/snack_bar_message.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      String piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }
}

extension FixMobile on String {
  String fixPhone() {
    if (startsWith('0')) return this;

    return '0$this';
  }

  String? checkPhoneNumber(BuildContext context, String phone) {
    if (phone.startsWith('00964') && phone.length > 11) return phone;
    if (phone.length < 10) {
      NoteMessage.showSnakeBar(context: context, message: AppStringManager.wrongPhone);
      return null;
    } else if (phone.startsWith("0") && phone.length < 11) {
      NoteMessage.showSnakeBar(context: context, message: AppStringManager.wrongPhone);
      return null;
    }

    if (phone.length > 10 && phone.startsWith("0")) phone = phone.substring(1);

    phone = '00964$phone';

    return phone;
  }
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get max => 2147483647;

  String get formatPrice => '${oCcy.format(this)}.0';
}

extension EnumHelper on Enum {
  String get arabicName {
    if (this is NavItems) {
      switch (this as NavItems) {
        case NavItems.home:
          return 'الرئيسية';
        case NavItems.students:
          return 'أرصدة الطلاب';
        case NavItems.notifications:
          return 'التبليغات';
        case NavItems.news:
          return 'الأخبار';
      }
    }
    if (this is HomeCards) {
      switch (this as HomeCards) {
        case HomeCards.students:
          return 'أرصدة الطلاب';
        case HomeCards.cashPayment:
          return 'حساب النقدية';
        case HomeCards.inventory:
          return 'جرد المخازن';
        case HomeCards.examTable:
          return 'جدول الامتحانات';
        case HomeCards.audit:
          return 'صافي الإيرادات';
        case HomeCards.debit:
          return 'صافي المصاريف';
        case HomeCards.teachers:
          return 'ذاتية المدرسين';
        case HomeCards.employees:
          return 'ذاتية الموظفين';
      }
    }
    return '';
  }

  String get icon {
    if (this is HomeCards) {
      switch (this as HomeCards) {
        case HomeCards.students:
          return Assets.iconsSDolar;
        case HomeCards.cashPayment:
          return Assets.iconsReportSDolar;
        case HomeCards.inventory:
          return Assets.iconsReportProducts;
        case HomeCards.examTable:
          return Assets.iconsAPlus;
        case HomeCards.audit:
          return Assets.iconsSDolarWithDb;
        case HomeCards.debit:
          return Assets.iconsCash;
        case HomeCards.teachers:
          return Assets.iconsReportInfo;
        case HomeCards.employees:
          return Assets.iconsNameTip;
      }
    }
    return '';
  }
}

extension UpdateTypeHelper on UpdateType {
  String get getName {
    switch (this) {
      case UpdateType.name:
        return 'تغيير الاسم';
      case UpdateType.phone:
        return 'تغير رقم الهاتف';
      case UpdateType.address:
        return 'تغير العنوان';
      case UpdateType.pass:
        return 'تغير كلمه المرور';
    }
  }
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBody => jsonDecode(body);
}

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

extension FormatDuration on Duration {
  String get format =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}

extension ApiStatusCode on int {
  bool get success => (this >= 200 && this <= 210);
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd').format(this);

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatTime $formatDate';

  DateTime addFromNow({int? year, int? month, int? day, int? hour}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

extension FirstItem<E> on Iterable<E> {
  E? get firstItem => isEmpty ? null : first;
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

// /// Returns a list of [DateTime]s between (but not including) [start] and
// /// [end], spaced by [period] intervals.
// List<DateTime> getDateTimesBetween1({
//   required DateTime start,
//   required DateTime end,
//   required Duration period,
// }) {
//   var dateTimes = <DateTime>[];
//   var current = start.add(period);
//   while (current.isBefore(end)) {
//     dateTimes.add(current);
//     current = current.add(period);
//   }
//   return dateTimes;
// }
