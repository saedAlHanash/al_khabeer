part of 'group_cubit.dart';

class GroupInitial extends Equatable {
  final CubitStatuses statuses;
  final List<MaterialDate> result;
  final String error;

  const GroupInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory GroupInitial.initial() {
    return GroupInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  String getNameByGuid(String guId) {
    for (var e in result) {
      if (e.guid == guId) return e.name;
    }
    return 'الكل';
  }

  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: '-', id: 1)];
    }
    return result
        .map((e) => SpinnerItem(
              name: e.name,
              item: e,
              id: e.id,
              guid: e.guid,
              isSelected: e.guid == selectedId,
            ))
        .toList();
  }

  GroupInitial copyWith({
    CubitStatuses? statuses,
    List<MaterialDate>? result,
    String? error,
  }) {
    return GroupInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
