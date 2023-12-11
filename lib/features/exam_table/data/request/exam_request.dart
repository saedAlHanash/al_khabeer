class ExamRequest {
  ExamRequest({
    this.stageGuid,
    this.classGuid,
    this.classLevelGuid,
  });

  String? stageGuid;
  String? classGuid;
  String? classLevelGuid;

  void setClass(String? classGuid) {
    this.classGuid = classGuid;
    stageGuid = null;
    classLevelGuid = null;
  }

  bool get canCall => stageGuid != null && classGuid != null && classLevelGuid != null;

  void setLevel(String? levelGuid) {
    classLevelGuid = levelGuid;
    stageGuid = null;
  }

  factory ExamRequest.fromJson(Map<String, dynamic> json) {
    return ExamRequest(
      stageGuid: json["stage_guid"] ?? "",
      classGuid: json["division_guid"] ?? "",
      classLevelGuid: json["level_guid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        //لا تقم بالتعديل
        // بسبب لغط ب الأسماء من طرف خنساء
        "division_guid": stageGuid, //الشعبة
        "stage_guid": classGuid, //المرحلة
        "level_guid": classLevelGuid, // الصف
      };
}
