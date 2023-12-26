part of 'transactions_cubit.dart';

class TransactionsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TransactionsData> result;
  final List<TransactionsData> filtered;
  final String error;
  final AccountRequest request;

  const TransactionsInitial({
    required this.statuses,
    required this.result,
    required this.filtered,
    required this.error,
    required this.request,
  });

  factory TransactionsInitial.initial() {
    return TransactionsInitial(
      result: [],
      filtered: [],
      error: '',
      request: AccountRequest(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: '-', id: 1)];
    }
    return result
        .map((e) => SpinnerItem(
              name: e.accountName,
              item: e,
              id: e.id,
              guid: e.accountGuid,
              isSelected: e.accountGuid == selectedId,
            ))
        .toList();
  }

  @override
  List<Object> get props => [statuses, result, error];

  TransactionsInitial copyWith({
    CubitStatuses? statuses,
    List<TransactionsData>? result,
    List<TransactionsData>? filtered,
    String? error,
    AccountRequest? request,
  }) {
    return TransactionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      filtered: filtered ?? this.filtered,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
