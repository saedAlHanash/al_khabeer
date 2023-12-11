class AccountsData {
  AccountsData({
    required this.id,
    required this.schoolId,
    required this.guid,
    required this.code,
    required this.parentGuid,
    required this.totalPaid,
    required this.totalCaught,
    required this.isParent,
    required this.balance,
    required this.subaccounts,
  });

  final int id;
  final String schoolId;
  final String guid;
  final String code;
  final String parentGuid;
  final int totalPaid;
  final num totalCaught;
  final bool isParent;
  final num balance;
  final List<AccountsData> subaccounts;

  factory AccountsData.fromJson(Map<String, dynamic> json) {
    return AccountsData(
      id: json["id"] ?? 0,
      schoolId: json["school_id"] ?? "",
      guid: json["guid"] ?? "",
      code: json["code"] ?? "",
      parentGuid: json["parent_guid"] ?? "",
      totalPaid: json["total_paid"] ?? 0,
      totalCaught: json["total_caught"] ?? 0,
      isParent: json["is_parent"] ?? false,
      balance: json["balance"] ?? 0,
      subaccounts: json["subaccounts"] == null
          ? []
          : List<AccountsData>.from(
              json["subaccounts"]!.map((x) => AccountsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "guid": guid,
        "code": code,
        "parent_guid": parentGuid,
        "total_paid": totalPaid,
        "total_caught": totalCaught,
        "is_parent": isParent,
        "balance": balance,
        "subaccounts": subaccounts.map((x) => x?.toJson()).toList(),
      };
}
