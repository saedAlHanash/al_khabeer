class AccountRequest {
  AccountRequest({
    this.accountGuid,
    this.startTime,
    this.endTime,
  });

  DateTime? startTime;
  DateTime? endTime;
  String? accountGuid;


  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
      accountGuid: json["account_guid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "account_guid": accountGuid,
    'from_date': startTime?.toIso8601String(),
    'to_date': endTime?.toIso8601String(),
  };
}
