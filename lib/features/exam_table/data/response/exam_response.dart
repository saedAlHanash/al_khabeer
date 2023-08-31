class ExamResponse {
  ExamResponse({
    required this.data,
  });

  final List<ExamData> data;

  factory ExamResponse.fromJson(Map<String, dynamic> json) {
    return ExamResponse(
      data: json["data"] == null
          ? []
          : List<ExamData>.from(json["data"]!.map((x) => ExamData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class ExamData {
  ExamData({
    required this.id,
    required this.stage,
    required this.stageEn,
    required this.level,
    required this.levelEn,
    required this.division,
    required this.divisionEn,
    required this.date,
    required this.examNo,
    required this.examType,
    required this.exams,
  });

  final int id;
  final String stage;
  final String stageEn;
  final String level;
  final String levelEn;
  final String division;
  final String divisionEn;
  final DateTime? date;
  final String examNo;
  final String examType;
  final List<Exam> exams;

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      id: json["id"] ?? 0,
      stage: json["stage"] ?? "",
      stageEn: json["stage_en"] ?? "",
      level: json["level"] ?? "",
      levelEn: json["level_en"] ?? "",
      division: json["division"] ?? "",
      divisionEn: json["division_en"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      examNo: json["exam_no"] ?? "",
      examType: json["exam_type"] ?? "",
      exams: json["exams"] == null
          ? []
          : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "stage": stage,
        "stage_en": stageEn,
        "level": level,
        "level_en": levelEn,
        "division": division,
        "division_en": divisionEn,
        "exam_no": examNo,
        "exam_type": examType,
        "exams": exams.map((x) => x.toJson()).toList(),
      };
}

class Exam {
  Exam({
    required this.material,
    required this.materialEn,
    required this.date,
    required this.examDay,
    required this.type,
    required this.note,
  });

  final String material;
  final String materialEn;
  final DateTime? date;
  final String examDay;
  final String type;
  final String note;

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      material: json["material"] ?? "",
      materialEn: json["material_en"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      examDay: json["exam_day"] ?? "",
      type: json["type"] ?? "",
      note: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "material": material,
        "material_en": materialEn,
        "exam_day": examDay,
        "type": type,
        "note": note,
      };
}
