class MaterialResponse {
  MaterialResponse({
    required this.data,
  });

  final List<MaterialDate> data;

  factory MaterialResponse.fromJson(Map<String, dynamic> json) {
    return MaterialResponse(
      data: json["data"] == null
          ? []
          : List<MaterialDate>.from(json["data"]!.map((x) => MaterialDate.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class MaterialDate {
  MaterialDate({
    required this.id,
    required this.guid,
    required this.name,
    required this.latinName,
    required this.parentGuid,
  });

  final int id;
  final String guid;
  final String name;
  final String latinName;
  final String parentGuid;

  factory MaterialDate.fromJson(Map<String, dynamic> json) {
    return MaterialDate(
      id: json["id"] ?? 0,
      guid: json["guid"] ?? "",
      name: json["name"] ?? "",
      latinName: json["latin_name"] ?? "",
      parentGuid: json["parent_guid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "guid": guid,
        "name": name,
        "latin_name": latinName,
        "parent_guid": parentGuid,
      };
}
