import 'package:tower_desktop_app/core/error/app_error.dart';

/// A sealed class representing the result of an operation.
///
/// Either [Success] containing data of type [T], or [Failure] containing an [AppError].
sealed class Result<T> {
  const Result();

  /// Create a success result
  factory Result.success(T data) = Success<T>;

  /// Create a failure result
  factory Result.failure(AppError error) = Failure<T>;

  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Get data if success, null otherwise
  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  /// Get error if failure, null otherwise
  AppError? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(:final error) => error,
      };

  /// Pattern match on result
  R when<R>({
    required R Function(T data) success,
    required R Function(AppError error) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Failure<T>(:final error) => failure(error),
    };
  }

  /// Map success value
  Result<R> map<R>(R Function(T data) mapper) {
    return switch (this) {
      Success<T>(:final data) => Result.success(mapper(data)),
      Failure<T>(:final error) => Result.failure(error),
    };
  }

  /// FlatMap success value
  Result<R> flatMap<R>(Result<R> Function(T data) mapper) {
    return switch (this) {
      Success<T>(:final data) => mapper(data),
      Failure<T>(:final error) => Result.failure(error),
    };
  }

  /// Get data or throw error
  T getOrThrow() {
    return switch (this) {
      Success<T>(:final data) => data,
      Failure<T>(:final error) => throw error,
    };
  }

  /// Get data or default value
  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T>(:final data) => data,
      Failure<T>() => defaultValue,
    };
  }
}

/// Success result containing data
final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';
}

/// Failure result containing error
final class Failure<T> extends Result<T> {
  final AppError error;

  const Failure(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}
