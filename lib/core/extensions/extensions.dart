import 'dart:convert';

import 'package:al_khabeer/core/api_manager/api_service.dart';
import 'package:al_khabeer/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../injection/injection_container.dart';
import '../strings/enum_manager.dart';
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
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    } else if (phone.startsWith("0") && phone.length < 11) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
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
          return S().home;
        case NavItems.students:
          return S().studentBalances;
        case NavItems.notifications:
          return S().notifications;
        case NavItems.news:
          return S().news;
      }
    }
    if (this is HomeCards) {

      switch (this as HomeCards) {
        case HomeCards.students:
          return S().studentBalances;
        case HomeCards.cashPayment:
          return S().studentAccounts;
        case HomeCards.inventory:
          return S().inventory;
        case HomeCards.examTable:
          return S().examsSchedule;
        case HomeCards.audit:
          return S().netRevenue;
        case HomeCards.debit:
          return S().netExpenses;
        case HomeCards.teachers:
          return S().teacherProfile;
        case HomeCards.employees:
          return S().staffProfile;
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
        return S().changeName;
      case UpdateType.phone:
        return S().changePhone;
      case UpdateType.address:
        return S().changeAddress;
      case UpdateType.pass:
        return S().changePassword;
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

  String get formatDate => DateFormat.yMd().format(this);

  String get formatDateMD => DateFormat.Md().format(this);

  String get formatTime {
    var t = DateFormat('h:mm a').format(this);

    return t.replaceAll('PM', 'م').replaceAll('AM', 'ص');
  }

  String get formatDateTime => '$formatDate $formatTime';

  String get formatFullDate => '$formatDayName  $formatDate  $formatTime';

  String get formatDayName {
    initializeDateFormatting();
    return DateFormat('EEEE', 'ar_SA').format(this);
  }

  DateTime addFromNow({int? year, int? month, int? day}) {
    return DateTime(
        this.year + (year ?? 0), this.month + (month ?? 0), this.day + (day ?? 0));
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);
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

BuildContext? get currentContext => sl<GlobalKey<NavigatorState>>().currentState?.context;
