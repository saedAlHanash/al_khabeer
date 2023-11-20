part of 'class_level_cubit.dart';

class ClassLevelInitial extends Equatable {
  final CubitStatuses statuses;
  final List<ClassData> result;
  final String error;

  const ClassLevelInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ClassLevelInitial.initial() {
    return ClassLevelInitial(
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
      return [SpinnerItem(name: 'الكل')];
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
      ..insert(0, SpinnerItem(name: 'الكل', id: 1));
  }

  ClassLevelInitial copyWith({
    CubitStatuses? statuses,
    List<ClassData>? result,
    String? error,
  }) {
    return ClassLevelInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
