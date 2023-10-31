part of 'student_cubit.dart';

class StudentInitial extends Equatable {
  final CubitStatuses statuses;
  final StudentsRequest request;
  final List<Student> result;
  final String error;

  const StudentInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory StudentInitial.initial() {
    return StudentInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      request: StudentsRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  StudentInitial copyWith({
    CubitStatuses? statuses,
    StudentsRequest? request,
    List<Student>? result,
    String? error,
  }) {
    return StudentInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
