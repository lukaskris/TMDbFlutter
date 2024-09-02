import 'package:equatable/equatable.dart';

/// Base failure
abstract class Failure extends Equatable implements Exception {
  /// @message hold error message
  const Failure([this.message = '']);

  /// hold error message
  final String message;

  @override
  String toString() => '$runtimeType Exception: $message';

  @override
  List<Object> get props => [];
}

/// General failures handle basic failure
class GenericFailure extends Failure {
  /// @message hold error message
  const GenericFailure({String message = ''}) : super(message);
}

/// API Failure handle failure API connection
class APIFailure extends Failure {
  /// @message hold error message
  const APIFailure({String message = ''}) : super(message);
}

/// This abstraction contains either a success data of generic type `S` or a
/// failure error of type `Failure` as its result.
///
/// `data` property must only be retrieved when `DataResult` was constructed by
/// using `DataResult.success(value)`. It can be validated by calling
/// `isSuccess` first. Alternatively, `dataOrElse` can be used instead since it
/// ensures a valid value is returned in case the result is a failure.
///
/// `error` must only be retrieved when `DataResult` was constructed by using
/// `DataResult.failure(error)`. It can be validated by calling `isFailure`
/// first.
abstract class DataResult<S> extends Equatable {
  /// Failure class
  static DataResult<S> failure<S>(Failure failure) => _FailureResult(failure);

  /// Success class
  static DataResult<S> success<S>(S data) => _SuccessResult(data);

  static DataResult<S> loading<S>() => _LoadingResult();

  /// Get [error] value, returns null when the value is actually [data]
  Failure? get error => fold<Failure?>((error) => error, (data) => null);

  /// Get [data] value, returns null when the value is actually [error]
  S? get data => fold<S?>((error) => null, (data) => data);

  /// Returns `true` if the object is of the `SuccessResult` type, which means
  /// `data` will return a valid result.
  bool get isSuccess => this is _SuccessResult<S>;

  /// Returns `true` if the object is of the `FailureResult` type, which means
  /// `error` will return a valid result.
  bool get isFailure => this is _FailureResult<S>;

  /// Returns `true` if the object is of the `LoadingResult` type, which means
  /// `loading` will return a valid result.
  bool get isLoading => this is _LoadingResult<S>;

  /// Returns `data` if `isSuccess` returns `true`, otherwise it returns
  /// `other`.
  S dataOrElse(S other) => isSuccess && data != null ? data! : other;

  /// Sugar syntax that calls `dataOrElse` under the hood. Returns left value if
  /// `isSuccess` returns `true`, otherwise it returns the right value.
  S operator |(S other) => dataOrElse(other);

  /// Transforms values of [error] and [data] in new a `DataResult` type. Only
  /// the matching function to the object type will be executed. For example,
  /// for a `SuccessResult` object only the [fnData] function will be executed.
  DataResult<T> either<T>(
    Failure Function(Failure error) fnFailure,
    T Function(S data) fnData,
  );

  /// Transforms value of [data] allowing a new `DataResult` to be returned.
  /// A `SuccessResult` might return a `FailureResult` and vice versa.
  DataResult<T> then<T>(DataResult<T> Function(S data) fnData);

  /// Transforms value of [data] always keeping the original identity of the
  /// `DataResult`, meaning that a `SuccessResult` returns a `SuccessResult` and
  /// a `FailureResult` always returns a `FailureResult`.
  DataResult<T> map<T>(T Function(S data) fnData);

  /// Folds [error] and [data] into the value of one type. Only the matching
  /// function to the object type will be executed. For example, for a
  /// `SuccessResult` object only the [fnData] function will be executed.
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData);

  @override
  List<Object?> get props => [if (isSuccess) data else error];
}

/// Success implementation of `DataResult`. It contains `data`. It's abstracted
/// away by `DataResult`. It shouldn't be used directly in the app.
class _SuccessResult<S> extends DataResult<S> {
  _SuccessResult(this._value);
  final S _value;

  @override
  _SuccessResult<T> either<T>(
    Failure Function(Failure error) fnFailure,
    T Function(S data) fnData,
  ) {
    return _SuccessResult<T>(fnData(_value));
  }

  @override
  DataResult<T> then<T>(DataResult<T> Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  _SuccessResult<T> map<T>(T Function(S data) fnData) {
    return _SuccessResult<T>(fnData(_value));
  }

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnData(_value);
  }
}

class _LoadingResult<S> extends DataResult<S> {
  @override
  DataResult<T> either<T>(
      Failure Function(Failure error) fnFailure, T Function(S data) fnData) {
    return _LoadingResult<T>();
  }

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnFailure(const GenericFailure());
  }

  @override
  DataResult<T> map<T>(T Function(S data) fnData) {
    return _LoadingResult<T>();
  }

  @override
  DataResult<T> then<T>(DataResult<T> Function(S data) fnData) {
    return _LoadingResult<T>();
  }
}

/// Failure implementation of `DataResult`. It contains `error`.  It's
/// abstracted away by `DataResult`. It shouldn't be used directly in the app.
class _FailureResult<S> extends DataResult<S> {
  _FailureResult(this._value);
  final Failure _value;

  @override
  _FailureResult<T> either<T>(
    Failure Function(Failure error) fnFailure,
    T Function(S data) fnData,
  ) {
    return _FailureResult<T>(fnFailure(_value));
  }

  @override
  _FailureResult<T> map<T>(T Function(S data) fnData) {
    return _FailureResult<T>(_value);
  }

  @override
  _FailureResult<T> then<T>(DataResult<T> Function(S data) fnData) {
    return _FailureResult<T>(_value);
  }

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnFailure(_value);
  }
}
