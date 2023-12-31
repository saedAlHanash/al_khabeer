import '../../../../core/util/cheker_helper.dart';

class EmployeesResponse {
  EmployeesResponse({
    required this.data,
  });

  final List<EmployData> data;

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) {
    return EmployeesResponse(
      data: json["data"] == null
          ? []
          : List<EmployData>.from(json["data"]!.map((x) => EmployData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class EmployData {
  EmployData(
    this._name, {
    required this.id,
    required this.latinName,
    required this.guid,
    required this.certificateName,
    required this.epithet,
    required this.salaryType,
    required this.dateEmployment,
  });

  final int id;
  final String _name;
  final String latinName;
  final String guid;
  final String certificateName;
  final String epithet;
  final String salaryType;
  final DateTime? dateEmployment;

  String get name => isAr ? _name : latinName.isEmpty
      ? _name
      : latinName.isEmpty
      ? _name
      : latinName;

  factory EmployData.fromJson(Map<String, dynamic> json) {
    return EmployData(
      json["name"] ?? "",
      id: json["id"] ?? 0,
      latinName: json["latin_name"] ?? "",
      guid: json["guid"] ?? "",
      certificateName: json["certificate_name"] ?? "",
      epithet: json["epithet"] ?? "",
      salaryType: json["salary_type"] ?? "",
      dateEmployment: DateTime.tryParse(json["date_employment"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": _name,
        "latin_name": latinName,
        "guid": guid,
        "certificate_name": certificateName,
        "epithet": epithet,
        "salary_type": salaryType,
        "date_employment": dateEmployment?.toIso8601String(),
      };
}
