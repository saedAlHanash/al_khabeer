import '../../../../core/util/cheker_helper.dart';

class StudentResponse {
  StudentResponse({
    required this.data,
  });

  final List<StudentData> data;

  factory StudentResponse.fromJson(Map<String, dynamic> json) {
    return StudentResponse(
      data: json["data"] == null
          ? []
          : List<StudentData>.from(json["data"]!.map((x) => StudentData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class StudentData {
  StudentData({
    required this.id,
    required this.studentguid,
    required this.studentnamelatin,
    required this.classguid,
    required this.classlevelguid,
    required this.stageguid,
    required this.paid,
    required this.sName,
    required this.cName,
    required this.cNameLatin,
    required this.cLevelName,
    required this.cLevelNameLatin,
    required this.stName,
    required this.stNameLatin,
    required this.caught,
    required this.date,
  });

  final int id;
  final String studentguid;
  final String sName;
  final String studentnamelatin;
  final String classguid;
  final String cName;
  final String cNameLatin;
  final String classlevelguid;
  final String cLevelName;
  final String cLevelNameLatin;
  final String stageguid;
  final String stName;
  final String stNameLatin;
  final String paid;
  final String caught;
  final DateTime? date;
  num? accountBalance;



  String get studentName => isAr
      ? sName
      : studentnamelatin.isEmpty
          ? sName
          : studentnamelatin;

  String get className => isAr
      ? cName
      : cNameLatin.isEmpty
          ? cName
          : cNameLatin;

  String get classlevelName => isAr
      ? cLevelName
      : cLevelNameLatin.isEmpty
          ? cLevelName
          : cLevelNameLatin;

  String get stageName => isAr
      ? stName
      : stNameLatin.isEmpty
          ? stName
          : stNameLatin;

  num get getAccountBalance => ((num.tryParse(caught) ?? 0) - (num.tryParse(paid) ?? 0));

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json["id"] ?? 0,
      studentguid: json["studentguid"] ?? "",
      studentnamelatin: json["studentnamelatin"] ?? "",
      classguid: json["classguid"] ?? "",
      classlevelguid: json["classlevelguid"] ?? "",
      stageguid: json["stageguid"] ?? "",
      paid: json["paid"] ?? "",
      caught: json["caught"] ?? "",
      sName: json["studentname"] ?? "",
      cName: json["class"] ?? "",
      cNameLatin: json["classlatin"] ?? "",
      cLevelName: json["classlevel"] ?? "",
      cLevelNameLatin: json["classlevellatin"] ?? "",
      stName: json["stage"] ?? "",
      stNameLatin: json["stagelatin"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentguid": studentguid,
        "studentname": sName,
        "studentnamelatin": studentnamelatin,
        "classguid": classguid,
        "classlevelguid": classlevelguid,
        "stageguid": stageguid,
        "paid": paid,
        "caught": caught,
      };
}
