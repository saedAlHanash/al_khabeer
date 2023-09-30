import '../../../../core/util/cheker_helper.dart';

class ClassResponse {
  ClassResponse({
    required this.data,
  });

  final List<ClassData> data;

  factory ClassResponse.fromJson(Map<String, dynamic> json) {
    return ClassResponse(
      data: json["data"] == null
          ? []
          : List<ClassData>.from(json["data"]!.map((x) => ClassData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class ClassData {
  ClassData(
     this._name,
      {
    required this.id,
    required this.guid,
    required this.schoolId,
    required this.code,
    required this.latinName,
    required this.stageId,
    required this.levelId,
  });

  final int id;
  final String guid;
  final String schoolId;
  final dynamic code;
  final String _name;
  final String latinName;
  final String stageId;
  final String levelId;

  String  get name=> isAr?_name:latinName.isEmpty
      ? _name
      : latinName;

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      json["name"] ?? "",
      id: json["id"] ?? 0,
      guid: json["uuid"] ?? "",
      schoolId: json["school_id"] ?? "",
      code: json["code"],
      stageId: json["stage_id"] ?? "",
      levelId: json["level_id"] ?? "",
      latinName: json["latin_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": guid,
        "school_id": schoolId,
        "code": code,
        "name": _name,
        "latin_name": latinName,
      };
}
