part of 'accounts_cubit.dart';

class AccountsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<AccountsData> result;
  final List<AccountsData> filtered;
  final String error;
  final AccountRequest request;

  const AccountsInitial({
    required this.statuses,
    required this.result,
    required this.filtered,
    required this.error,
    required this.request,
  });

  factory AccountsInitial.initial() {
    return AccountsInitial(
      result: [],
      filtered: [],
      error: '',
      request: AccountRequest(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'الكل', id: 1)];
    }
    return result
        .map((e) => SpinnerItem(
              name: e.name,
              item: e,
              id: e.id,
              guid: e.guid,
              isSelected: e.guid == selectedId,
            ))
        .toList()
      ..insert(0, SpinnerItem(name: 'الكل',id: 1));
  }

  @override
  List<Object> get props => [statuses, result, error];

  AccountsInitial copyWith({
    CubitStatuses? statuses,
    List<AccountsData>? result,
    List<AccountsData>? filtered,
    String? error,
    AccountRequest? request,
  }) {
    return AccountsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      filtered: filtered ?? this.filtered,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
