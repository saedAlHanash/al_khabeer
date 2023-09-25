

class TransactionsResponse {
  TransactionsResponse({
    required this.data,
  });

  final List<TransactionsData> data;

  factory TransactionsResponse.fromJson(Map<String, dynamic> json){
    return TransactionsResponse(
      data: json["data"] == null ? [] : List<TransactionsData>.from(
          json["data"]!.map((x) => TransactionsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "data": data.map((x) => x.toJson()).toList(),
      };

}

class TransactionsData {
  TransactionsData({
    required this.id,
    required this.accountGuid,
    required this.accountName,
    required this.paid,
    required this.caught,
    required this.date,
    required this.note,
  });

  final int id;
  final String accountGuid;
  final String accountName;
  final String paid;
  final String caught;
  final DateTime? date;
  final String note;

  num get getAccountBalance {
    var t = num.parse(caught) - num.parse(paid);
    return t;
  }

  factory TransactionsData.fromJson(Map<String, dynamic> json){
    return TransactionsData(
      id: json["id"] ?? 0,
      accountGuid: json["account_guid"] ?? "",
      accountName: json["account"] ?? "",
      paid: json["paid"] ?? "",
      caught: json["caught"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      note: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "account_guid": accountGuid,
        "paid": paid,
        "caught": caught,
        "note": note,
      };

}
