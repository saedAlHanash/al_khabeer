class StudentsRequest {
  StudentsRequest({
    this.stageGuid,
    this.classGuid,
    this.classLevelGuid,
  });

  String? stageGuid;
  String? classGuid;
  String? classLevelGuid;

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
        "classlevel_guid": classLevelGuid,
      };
}
