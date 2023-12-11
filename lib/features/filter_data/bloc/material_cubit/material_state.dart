part of 'material_cubit.dart';

class MaterialInitial extends Equatable {
  final CubitStatuses statuses;
  final List<MaterialDate> result;
  final String error;

  const MaterialInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory MaterialInitial.initial() {
    return MaterialInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  String? getNameByGuid(String guId) {

    for (var e in result) {
      if (e.guid == guId) return e.name;
    }
    return null;
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
        .toList();
  }

  MaterialInitial copyWith({
    CubitStatuses? statuses,
    List<MaterialDate>? result,
    String? error,
  }) {
    return MaterialInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
