class AccountRequest {
  AccountRequest({
    this.accountGuid,
    this.type,
    this.startTime,
    this.endTime,
  });

  DateTime? startTime;
  DateTime? endTime;
  String? accountGuid;
  String? type;


  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
      accountGuid: json["account_guid"] ?? "",
      type: json["type"] ?? "",
    );
  }


  Map<String, dynamic> toJson() => {
    "account_guid": accountGuid,
    "type": type,
    'from_date': startTime?.toIso8601String(),
    'to_date': endTime?.toIso8601String(),
  };

  AccountRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? accountGuid,
    String? type,
  }) {
    return AccountRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      accountGuid: accountGuid ?? this.accountGuid,
      type: type ?? this.type,
    );
  }
}
