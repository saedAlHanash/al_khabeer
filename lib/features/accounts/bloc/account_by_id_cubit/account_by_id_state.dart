part of 'account_by_id_cubit.dart';

class AccountByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final List<AccountsData> result;
  final String error;
  final AccountRequest request;

  const AccountByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory AccountByIdInitial.initial() {
    return AccountByIdInitial(
      result: const [],
      error: '',
      request: AccountRequest(),
      statuses: CubitStatuses.init,
    );
  }

  num get getAllAccountBalance =>
      result.fold(0, (acc, e) => acc + (!e.isParent ? 0 : e.balance));

  // List<SpinnerItem> getSpinnerItems({String? selectedId}) {
  //   if (result.isEmpty) {
  //     return [SpinnerItem(name: '-', id: 1)];
  //   }
  //   return result
  //       .map((e) => SpinnerItem(
  //             name: e.name,
  //             item: e,
  //             id: e.id,
  //             guid: e.guid,
  //             isSelected: e.guid == selectedId,
  //           ))
  //       .toList()
  //     ..insert(0, SpinnerItem(name: 'الكل',id: 1));
  // }

  @override
  List<Object> get props => [statuses, result, error];

  AccountByIdInitial copyWith({
    CubitStatuses? statuses,
    List<AccountsData>? result,
    String? error,
    AccountRequest? request,
  }) {
    return AccountByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
