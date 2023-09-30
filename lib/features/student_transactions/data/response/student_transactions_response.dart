import '../../../students/data/response/students_respose.dart';

class StudentTransactionsResponse {
  StudentTransactionsResponse({
    required this.data,
  });

  final List<StudentData> data;

  factory StudentTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return StudentTransactionsResponse(
      data: json["data"] == null
          ? []
          : List<StudentData>.from(
              json["data"]!.map((x) => StudentData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}


