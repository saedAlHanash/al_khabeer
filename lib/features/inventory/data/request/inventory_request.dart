class InventoryRequest {
  InventoryRequest({
    this.materialGuid,
    this.groupGuid,
    this.sortBy,
    this.startTime,
    this.endTime,
  });

  DateTime? startTime;
  DateTime? endTime;
  String? groupGuid;

  String? materialGuid;
  String? sortBy;

  factory InventoryRequest.fromJson(Map<String, dynamic> json) {
    return InventoryRequest(
      materialGuid: json["materialguid"] ?? "",
      groupGuid: json["material_group_guid"] ?? "",
      sortBy: json["sort_by"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "materialguid": materialGuid,
        "material_group_guid": groupGuid,
        "sort_by": sortBy,
        'from_date': startTime?.toIso8601String(),
        'to_date': endTime?.toIso8601String(),
      };
}
