part of 'news_cubit.dart';

class NewsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<NewsData> result;
  final String error;

  const NewsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory NewsInitial.initial() {
    return NewsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];



  NewsInitial copyWith({
    CubitStatuses? statuses,
    List<NewsData>? result,
    String? error,
  }) {
    return NewsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
