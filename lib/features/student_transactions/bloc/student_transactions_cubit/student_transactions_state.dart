part of 'student_transactions_cubit.dart';

class StudentTransactionsInitial extends Equatable {
  final CubitStatuses statuses;
  final StudentTransactionsRequest request;
  final List<StudentTransactionsData> result;
  final String error;

  const StudentTransactionsInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory StudentTransactionsInitial.initial() {
    return StudentTransactionsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      request: StudentTransactionsRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  StudentTransactionsInitial copyWith({
    CubitStatuses? statuses,
    StudentTransactionsRequest? request,
    List<StudentTransactionsData>? result,
    String? error,
  }) {
    return StudentTransactionsInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
