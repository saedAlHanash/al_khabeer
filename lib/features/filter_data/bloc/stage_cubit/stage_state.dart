part of 'stage_cubit.dart';

class StageInitial extends Equatable {
  final CubitStatuses statuses;
  final List<ClassData> result;
  final String error;

  const StageInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory StageInitial.initial() {
    return StageInitial(
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
        .toList() ;
  }

  StageInitial copyWith({
    CubitStatuses? statuses,
    List<ClassData>? result,
    String? error,
  }) {
    return StageInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
