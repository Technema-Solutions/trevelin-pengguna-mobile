/// Simple result class representing success or failure.
class Result<T> {
  final T? data;
  final Object? error;

  const Result._({this.data, this.error});

  bool get isSuccess => error == null;

  static Result<T> success<T>(T data) => Result<T>._(data: data);
  static Result<T> failure<T>(Object error) => Result<T>._(error: error);
}
