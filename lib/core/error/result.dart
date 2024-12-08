import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_manga_editor/core/error/exceptions.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(AppException error) = Failure<T>;
}

extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => when(
        success: (data) => data,
        failure: (_) => null,
      );

  AppException? get errorOrNull => when(
        success: (_) => null,
        failure: (error) => error,
      );

  R when<R>({
    required R Function(T data) success,
    required R Function(AppException error) failure,
  }) {
    return map(
      success: (s) => success(s.data),
      failure: (f) => failure(f.error),
    );
  }
}
