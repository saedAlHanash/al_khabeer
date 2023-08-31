class InventoryRequest {
  InventoryRequest({
     this.materialGuid,
     this.groupGuid,
    this.sortBy,
  });

   String? groupGuid;
   // String? groupName;
   String? materialGuid;
   // String? materialName;
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
      };
}
