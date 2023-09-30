import '../../../../core/util/cheker_helper.dart';

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
  InventoryData(
    this._name, {
    required this.id,
    required this.materialguid,
    required this.materialGroupGuid,
    required this.mName,
    required this.mNameLatin,
    required this.materialGroupName,
    required this.quantity,
    required this.date,
    required this.latinName,
    required this.note,
    required this.unit,
  });

  final int id;
  final String materialguid;
  final String materialGroupGuid;
  final String mName;
  final String mNameLatin;
  final String materialGroupName;
  final String quantity;
  final String _name;
  final String latinName;
  final DateTime? date;
  final String note;
  final String unit;

  String get name => isAr
      ? _name
      : latinName.isEmpty
          ? _name
          : latinName;

  String get materialName => isAr
      ? mName
      : latinName.isEmpty
          ? mName
          : latinName;

  factory InventoryData.fromJson(Map<String, dynamic> json) {
    return InventoryData(
      json["name"] ?? '',
      id: json["id"] ?? 0,
      latinName: json["latinName"] ?? '',
      materialguid: json["materialguid"] ?? "",
      materialGroupGuid: json["material_group_guid"] ?? "",
      mName: json["material"] ?? "",
      mNameLatin: json["materiallatin"] ?? "",
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
        "name": _name,
        "latinName": latinName,
        //date : '',
        "note": note,
        "unit": unit,
      };
}
