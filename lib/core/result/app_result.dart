import '../errors/app_failure.dart';

sealed class AppResult<T> {
  const AppResult();

  bool get isSuccess => this is AppSuccess<T>;
  bool get isFailure => this is AppError<T>;
}

class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.value);

  final T value;
}

class AppError<T> extends AppResult<T> {
  const AppError(this.failure);

  final AppFailure failure;
}
