import '../response/accouts_response.dart';

class AccountRequest {
  AccountRequest({
    this.account,
    this.type,
    this.startTime,
    this.endTime,
  });

  DateTime? startTime;
  DateTime? endTime;
  AccountsData? account;
  String? type;


  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
      account: json["account_guid"] ?? "",
      type: json["type"] ?? "",
    );
  }


  Map<String, dynamic> toJson() => {
    "account_guid": account?.guid,
    "type": type,
    'from_date': startTime?.toIso8601String(),
    'to_date': endTime?.toIso8601String(),
  };

  AccountRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    AccountsData? account,
    String? type,
  }) {
    return AccountRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      account: account ?? this.account,
      type: type ?? this.type,
    );
  }
}
