class AccountsResponse {
  AccountsResponse({
    required this.data,
  });

  final List<AccountsData> data;

  factory AccountsResponse.fromJson(Map<String, dynamic> json){
    return AccountsResponse(
      data: json["data"] == null ? [] : List<AccountsData>.from(json["data"]!.map((x) => AccountsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

class AccountsData {
  AccountsData({
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

  factory AccountsData.fromJson(Map<String, dynamic> json){
    return AccountsData(
      id: json["id"] ?? 0,
      guid: json["guid"] ?? "",
      name: json["name"] ?? "",
      latinName: json["latin_name"] ?? "",
      parentGuid: json["parent_guid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "guid": guid,
    "name": name,
    "latin_name": latinName,
    "parent_guid": parentGuid,
  };

}
