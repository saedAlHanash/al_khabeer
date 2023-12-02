import '../../../../core/util/cheker_helper.dart';

class AccountsResponse {
  AccountsResponse({
    required this.data,
  });

  final List<AccountsData> data;

  factory AccountsResponse.fromJson(Map<String, dynamic> json) {
    return AccountsResponse(
      data: json["data"] == null
          ? []
          : List<AccountsData>.from(json["data"]!.map((x) => AccountsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class AccountsData {
  AccountsData(
    this._name, {
    required this.id,
    required this.guid,
    required this.latinName,
    required this.parentGuid,
        required this.balance,
  });

  final int id;
  final String guid;
  final String _name;
  final String latinName;
  final String parentGuid;
  final num balance;

  String get name => isAr
      ? _name
      : latinName.isEmpty
          ? _name
          : latinName;

  factory AccountsData.fromJson(Map<String, dynamic> json) {
    return AccountsData(
      json["name"] ?? "",
      id: json["id"] ?? 0,
      guid: json["guid"] ?? "",
      latinName: json["latin_name"] ?? "",
      parentGuid: json["parent_guid"] ?? "",
      balance: json["balance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "name": _name,
        "latin_name": latinName,
        "parent_guid": parentGuid,
    "balance": balance,
      };
}
