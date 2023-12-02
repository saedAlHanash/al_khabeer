import '../../../../core/util/cheker_helper.dart';

class TransactionsResponse {
  TransactionsResponse({
    required this.data,
  });

  final List<TransactionsData> data;

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionsResponse(
      data: json["data"] == null
          ? []
          : List<TransactionsData>.from(
              json["data"]!.map((x) => TransactionsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TransactionsData {
  TransactionsData(
    this._accountName, {
    required this.id,
    required this.accountGuid,
    required this.accountNameLatin,
    required this.paid,
    required this.balance,
    required this.caught,
    required this.date,
    required this.note,
  });

  final int id;
  final String accountGuid;
  final String _accountName;
  final String accountNameLatin;
  final String paid;
  final num balance;
  final String caught;
  final DateTime? date;
  final String note;

  num get getAccountBalance {
    var t = num.parse(caught) - num.parse(paid);
    return t;
  }

  String get accountName => isAr
      ? _accountName
      : accountNameLatin.isEmpty
          ? _accountName
          : accountNameLatin;

  factory TransactionsData.fromJson(Map<String, dynamic> json) {
    return TransactionsData(
      json["account"] ?? "",
      id: json["id"] ?? 0,
      accountGuid: json["account_guid"] ?? "",
      accountNameLatin: json["accountlatin"] ?? "",
      paid: json["paid"] ?? "",
      balance: json["balance"] ?? 0,
      caught: json["caught"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      note: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_guid": accountGuid,
        "paid": paid,
        "balance": balance,
        "caught": caught,
        "note": note,
      };
}
