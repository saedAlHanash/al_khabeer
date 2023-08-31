class StudentTransactionsResponse {
  StudentTransactionsResponse({
    required this.data,
  });

  final List<StudentTransactionsData> data;

  factory StudentTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return StudentTransactionsResponse(
      data: json["data"] == null
          ? []
          : List<StudentTransactionsData>.from(
              json["data"]!.map((x) => StudentTransactionsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class StudentTransactionsData {
  StudentTransactionsData({
    required this.id,
    required this.studentguid,
    required this.studentname,
    required this.studentnamelatin,
    required this.classguid,
    required this.classlevelguid,
    required this.stageguid,
    required this.paid,
    required this.caught,
    required this.date,
    required this.className,
    required this.classlevelName,
    required this.stageName,
  });

  final int id;
  final String studentguid;
  final String studentname;
  final String studentnamelatin;
  final String classguid;
  final String classlevelguid;
  final String stageguid;
  final String className;
  final String classlevelName;
  final String stageName;
  final String paid;
  final String caught;
  final DateTime? date;


  factory StudentTransactionsData.fromJson(Map<String, dynamic> json) {
    return StudentTransactionsData(
      id: json["id"] ?? 0,
      studentguid: json["studentguid"] ?? "",
      studentname: json["studentname"] ?? "",
      studentnamelatin: json["studentnamelatin"] ?? "",
      classguid: json["classguid"] ?? "",
      classlevelguid: json["classlevelguid"] ?? "",
      stageguid: json["stageguid"] ?? "",
      paid: json["paid"] ?? "",
      caught: json["caught"] ?? "",
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
