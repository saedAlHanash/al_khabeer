part of 'exam_cubit.dart';

class ExamInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Exam> result;
  final String error;

  const ExamInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ExamInitial.initial() {
    return ExamInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ExamInitial copyWith({
    CubitStatuses? statuses,
    List<Exam>? result,
    String? error,
  }) {
    return ExamInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
