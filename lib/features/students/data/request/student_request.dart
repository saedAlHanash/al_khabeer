class StudentsRequest {
  StudentsRequest({
    this.stageGuid,
    this.classGuid,
    this.classLevelGuid,
    this.startTime,
    this.endTime,
  });

  String? stageGuid;
  String? classGuid;
  String? classLevelGuid;
  DateTime? startTime;
  DateTime? endTime;


  void setClass(String? classGuid) {
    this.classGuid = classGuid;
    stageGuid = null;
    classLevelGuid = null;
  }

  void setLevel(String? levelGuid) {
    classLevelGuid = levelGuid;
    stageGuid = null;
  }

  factory StudentsRequest.fromJson(Map<String, dynamic> json) {
    return StudentsRequest(
      stageGuid: json["stage_guid"] ?? "",
      classGuid: json["class_guid"] ?? "",
      classLevelGuid: json["classlevel_guid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "stage_guid": stageGuid,
        "class_guid": classGuid,
        "group": true,
        "classlevel_guid": classLevelGuid,
        'from_date': startTime?.toIso8601String(),
        'to_date': endTime?.toIso8601String(),
      };
}
