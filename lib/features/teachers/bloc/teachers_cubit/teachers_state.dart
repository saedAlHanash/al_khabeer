part of 'teachers_cubit.dart';

class TeachersInitial extends Equatable {
  final CubitStatuses statuses;
  final InventoryRequest request;
  final List<EmployData> result;
  final String error;

  const TeachersInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory TeachersInitial.initial() {
    return TeachersInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      request: InventoryRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];



  TeachersInitial copyWith({
    CubitStatuses? statuses,
    InventoryRequest? request,
    List<EmployData>? result,
    String? error,
  }) {
    return TeachersInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
