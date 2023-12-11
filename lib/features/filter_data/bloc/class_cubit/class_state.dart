part of 'class_cubit.dart';

class ClassInitial extends Equatable {
  final CubitStatuses statuses;
  final List<ClassData> result;
  final String error;

  const ClassInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ClassInitial.initial() {
    return ClassInitial(
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
      ..insert(0, SpinnerItem(name: 'الكل', id: 1));
  }

  ClassInitial copyWith({
    CubitStatuses? statuses,
    List<ClassData>? result,
    String? error,
  }) {
    return ClassInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
