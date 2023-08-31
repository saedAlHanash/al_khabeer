class InventoryResponse {
  InventoryResponse({
    required this.data,
  });

  final List<InventoryData> data;

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      data: json["data"] == null
          ? []
          : List<InventoryData>.from(json["data"]!.map((x) => InventoryData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class InventoryData {
  InventoryData({
    required this.id,
    required this.materialguid,
    required this.materialGroupGuid,
    required this.materialName,
    required this.materialGroupName,
    required this.quantity,
    required this.date,
    required this.name,
    required this.note,
    required this.unit,
  });

  final int id;
  final String materialguid;
  final String materialGroupGuid;
  final String materialName;
  final String materialGroupName;
  final String quantity;
  final String name;
  final DateTime? date;
  final String note;
  final String unit;

  factory InventoryData.fromJson(Map<String, dynamic> json) {
    return InventoryData(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      materialguid: json["materialguid"] ?? "",
      materialGroupGuid: json["material_group_guid"] ?? "",
      materialName: json["material"] ?? "",
      materialGroupName: json["material_group"] ?? "",
      quantity: json["quantity"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      note: json["note"] ?? "",
      unit: json["unit"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "materialguid": materialguid,
        "material_group_guid": materialGroupGuid,
        "quantity": quantity,
        "name": name,
        //date : '',
        "note": note,
        "unit": unit,
      };
}
