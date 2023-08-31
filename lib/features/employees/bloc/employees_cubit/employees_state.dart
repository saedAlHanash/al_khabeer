part of 'employees_cubit.dart';

class EmployeesInitial extends Equatable {
  final CubitStatuses statuses;
  final InventoryRequest request;
  final List<EmployData> result;
  final String error;

  const EmployeesInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory EmployeesInitial.initial() {
    return EmployeesInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      request: InventoryRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];



  EmployeesInitial copyWith({
    CubitStatuses? statuses,
    InventoryRequest? request,
    List<EmployData>? result,
    String? error,
  }) {
    return EmployeesInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
