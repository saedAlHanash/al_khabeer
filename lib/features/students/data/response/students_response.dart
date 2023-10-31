import 'package:al_khabeer/core/extensions/extensions.dart';

import '../../../../core/util/cheker_helper.dart';

class StudentsResponse {
  StudentsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<Student> data;

  factory StudentsResponse.fromJson(Map<String, dynamic> json) {
    return StudentsResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null
          ? []
          : List<Student>.from(json["data"]!.map((x) => Student.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Student {
  Student({
    required this.id,
    required this.schoolId,
    required this.studentguid,
    required this.studentname,
    required this.studentnamelatin,
    required this.classguid,
    required this.classlevelguid,
    required this.stageguid,
    required this.school,
    required this.stage,
    required this.stageEn,
    required this.level,
    required this.levelEn,
    required this.division,
    required this.divisionEn,
    required this.className1,
    required this.classlatin,
    required this.sumPaid,
    required this.sumCaught,
    required this.balance,
    required this.transactions,
  });

  final int id;
  final String schoolId;
  final String studentguid;
  final String studentname;
  final String studentnamelatin;
  final String classguid;
  final String classlevelguid;
  final String stageguid;
  final School? school;
  final String stage;
  final String stageEn;
  final String level;
  final String levelEn;
  final String division;
  final String divisionEn;
  final String className1;
  final String classlatin;
  final dynamic sumPaid;
  final String sumCaught;
  final num balance;
  final List<Transaction> transactions;

  String get studentName => isAr
      ? studentname
      : studentnamelatin.isEmpty
      ? studentname
      : studentnamelatin;

  String get className => isAr
      ? level
      : levelEn.isEmpty
      ? level
      : levelEn;


  String get stageName => isAr
      ? stage
      : stageEn.isEmpty
      ? stage
      : stageEn;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"] ?? 0,
      schoolId: json["school_id"] ?? "",
      studentguid: json["studentguid"] ?? "",
      studentname: json["studentname"] ?? "",
      studentnamelatin: json["studentnamelatin"] ?? "",
      classguid: json["classguid"] ?? "",
      classlevelguid: json["classlevelguid"] ?? "",
      stageguid: json["stageguid"] ?? "",
      school: json["school"] == null ? null : School.fromJson(json["school"]),
      stage: json["stage"] ?? "",
      stageEn: json["stage_en"] ?? "",
      level: json["level"] ?? "",
      levelEn: json["level_en"] ?? "",
      division: json["division"] ?? "",
      divisionEn: json["division_en"] ?? "",
      className1: json["class"] ?? "",
      classlatin: json["classlatin"] ?? "",
      sumPaid: json["sum_paid"]??"",
      sumCaught: json["sum_caught"] ?? "",
      balance: json["balance"] ?? 0,
      transactions: json["transactions"] == null
          ? []
          : List<Transaction>.from(
              json["transactions"]!.map((x) => Transaction.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "studentguid": studentguid,
        "studentname": studentname,
        "studentnamelatin": studentnamelatin,
        "classguid": classguid,
        "classlevelguid": classlevelguid,
        "stageguid": stageguid,
        "school": school?.toJson(),
        "stage": stage,
        "stage_en": stageEn,
        "level": level,
        "level_en": levelEn,
        "division": division,
        "division_en": divisionEn,
        "class": className1,
        "classlatin": classlatin,
        "sum_paid": sumPaid,
        "sum_caught": sumCaught,
        "balance": balance,
        "transactions": transactions.map((x) => x?.toJson()).toList(),
      };
}

class School {
  School({
    required this.id,
    required this.slug,
    required this.name,
    required this.code,
    required this.slogan,
    required this.logo,
    required this.phone,
    required this.phone2,
    required this.email,
    required this.website,
    required this.address,
    required this.socialMedia,
    required this.policies,
    required this.vision,
    required this.mission,
    required this.aboutUs,
    required this.subscriptionId,
    required this.subscriptionDate,
    required this.period,
    required this.expiryDate,
    required this.gpsToken,
    required this.welcomeMessage,
    required this.options,
  });

  final int id;
  final String slug;
  final String name;
  final String code;
  final dynamic slogan;
  final String logo;
  final String phone;
  final String phone2;
  final String email;
  final String website;
  final String address;
  final SocialMedia? socialMedia;
  final dynamic policies;
  final String vision;
  final String mission;
  final String aboutUs;
  final String subscriptionId;
  final DateTime? subscriptionDate;
  final String period;
  final DateTime? expiryDate;
  final String gpsToken;
  final dynamic welcomeMessage;
  final dynamic options;

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      slogan: json["slogan"],
      logo: json["logo"] ?? "",
      phone: json["phone"] ?? "",
      phone2: json["phone2"] ?? "",
      email: json["email"] ?? "",
      website: json["website"] ?? "",
      address: json["address"] ?? "",
      socialMedia: json["social_media"] == null
          ? null
          : SocialMedia.fromJson(json["social_media"]),
      policies: json["policies"],
      vision: json["vision"] ?? "",
      mission: json["mission"] ?? "",
      aboutUs: json["about_us"] ?? "",
      subscriptionId: json["subscription_id"] ?? "",
      subscriptionDate: DateTime.tryParse(json["subscription_date"] ?? ""),
      period: json["period"] ?? "",
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      gpsToken: json["gps_token"] ?? "",
      welcomeMessage: json["welcome_message"],
      options: json["options"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "code": code,
        "slogan": slogan,
        "logo": logo,
        "phone": phone,
        "phone2": phone2,
        "email": email,
        "website": website,
        "address": address,
        "social_media": socialMedia?.toJson(),
        "policies": policies,
        "vision": vision,
        "mission": mission,
        "about_us": aboutUs,
        "subscription_id": subscriptionId,
        "subscription_date": subscriptionDate?.toIso8601String(),
        "period": period,
        "expiry_date": expiryDate?.toIso8601String(),
        "gps_token": gpsToken,
        "welcome_message": welcomeMessage,
        "options": options,
      };
}

class SocialMedia {
  SocialMedia({
    required this.facebook,
    required this.instagram,
    required this.snap,
    required this.youtube,
  });

  final String facebook;
  final String instagram;
  final String snap;
  final String youtube;

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      facebook: json["facebook"] ?? "",
      instagram: json["instagram"] ?? "",
      snap: json["snap"] ?? "",
      youtube: json["youtube"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "snap": snap,
        "youtube": youtube,
      };
}

class Transaction {
  Transaction({
    required this.paid,
    required this.caught,
    required this.date,
  });

  final String paid;
  final String caught;
  final DateTime? date;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      paid: json["paid"] ?? "",
      caught: json["caught"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "paid": paid,
        "caught": caught,
        "date": date?.toIso8601String(),
      };
}
