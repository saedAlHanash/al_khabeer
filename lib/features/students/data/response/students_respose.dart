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
    required this.studentname,
    required this.studentnamelatin,
    required this.classguid,
    required this.classlevelguid,
    required this.stageguid,
    required this.paid,
    required this.studentName,
    required this.className,
    required this.classlevelName,
    required this.stageName,
    required this.caught,
    required this.date,
  });

  final int id;
  final String studentguid;
  final String studentName;
  final String studentname;
  final String studentnamelatin;
  final String classguid;
  final String className;
  final String classlevelguid;
  final String classlevelName;
  final String stageguid;
  final String stageName;
  final String paid;
  final String caught;
  final DateTime? date;
  num? accountBalance;

  num get getAccountBalance => ((num.tryParse(caught) ?? 0) - (num.tryParse(paid) ?? 0));

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json["id"] ?? 0,
      studentguid: json["studentguid"] ?? "",
      studentname: json["studentname"] ?? "",
      studentnamelatin: json["studentnamelatin"] ?? "",
      classguid: json["classguid"] ?? "",
      classlevelguid: json["classlevelguid"] ?? "",
      stageguid: json["stageguid"] ?? "",
      paid: json["paid"] ?? "",
      caught: json["caught"] ?? "",
      studentName: json["studentname"] ?? "",
      className: json["class"] ?? "",
      classlevelName: json["classlevel"] ?? "",
      stageName: json["stage"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentguid": studentguid,
        "studentname": studentname,
        "studentnamelatin": studentnamelatin,
        "classguid": classguid,
        "classlevelguid": classlevelguid,
        "stageguid": stageguid,
        "paid": paid,
        "caught": caught,
      };
}
