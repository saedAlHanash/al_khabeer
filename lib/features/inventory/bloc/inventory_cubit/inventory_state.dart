part of 'inventory_cubit.dart';

class InventoryInitial extends Equatable {
  final CubitStatuses statuses;
  final InventoryRequest request;
  final List<InventoryData> result;
  final String error;

  const InventoryInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory InventoryInitial.initial() {
    return InventoryInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      request: InventoryRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  double get getQuantity {
    return result.fold(0.0, (previousValue,e) => previousValue + (num.tryParse(e.quantity)??0));
  }
  InventoryInitial copyWith({
    CubitStatuses? statuses,
    InventoryRequest? request,
    List<InventoryData>? result,
    String? error,
  }) {
    return InventoryInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
