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
    required this.schoolId,
    required this.code,
    required this.totalPaid,
    required this.totalCaught,
    required this.isParent,
    required this.subaccounts,
  });

  final int id;
  final String guid;
  final String _name;
  final String latinName;
  final String parentGuid;
  final num balance;
  final String schoolId;
  final String code;
  final int totalPaid;
  final num totalCaught;
   bool isParent;
  final List<AccountsData> subaccounts;

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
      schoolId: json["school_id"] ?? "",
      code: json["code"] ?? "",
      totalPaid: json["total_paid"] ?? 0,
      totalCaught: json["total_caught"] ?? 0,
      isParent: json["is_parent"] ?? false,
      subaccounts: json["subaccounts"] == null
          ? []
          : List<AccountsData>.from(
              json["subaccounts"]!.map((x) => AccountsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "name": _name,
        "latin_name": latinName,
        "parent_guid": parentGuid,
        "balance": balance,
        "school_id": schoolId,
        "code": code,
        "total_paid": totalPaid,
        "total_caught": totalCaught,
        "is_parent": isParent,
        "subaccounts": subaccounts.map((x) => x.toJson()).toList(),
      };
}

List<AccountsData> getAllSubAccounts(AccountsData? account) {

  if(account ==null)return <AccountsData>[];

  final r = <AccountsData>[];
  r.add(account);
  for (var e in account.subaccounts) {
    r.addAll(getAllSubAccounts(e));
  }
  return r;
}
