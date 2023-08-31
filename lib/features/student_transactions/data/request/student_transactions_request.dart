class StudentTransactionsRequest {
  StudentTransactionsRequest({
    this.studentguid,
    this.classguid,
    this.classlevelguid,
    this.stageguid,
    this.date,
  });

  String? studentguid;
  String? classguid;
  String? classlevelguid;
  String? stageguid;
  DateTime? date;

  factory StudentTransactionsRequest.fromJson(Map<String, dynamic> json) {
    return StudentTransactionsRequest(
      studentguid: json["studentguid"] ?? "",
      classguid: json["classguid"] ?? "",
      classlevelguid: json["classlevelguid"] ?? "",
      stageguid: json["stageguid"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "studentguid": studentguid,
        "classguid": classguid,
        "classlevelguid": classlevelguid,
        "stageguid": stageguid,
        "sort_by": 'date',
        // "date": "${date.year.toString().padLeft(4'0')}-${date.month.toString().padLeft(2'0')}-${date.day.toString().padLeft(2'0')}",
      };
}
