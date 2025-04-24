abstract class Result<T> {
  R fold<R>(R Function(Exception e) onError, R Function(T data) onSuccess);

  bool isError() => this is Error<T>;
  bool isSuccess() => this is Success<T>;

  T? getOrNull() => isSuccess() ? (this as Success<T>).value : null;

  T getOrThrow() {
    if (isSuccess()) {
      return (this as Success<T>).value;
    } else {
      throw (this as Error<T>).exception;
    }
  }

  T getOrDefault(T defaultValue) => isSuccess() ? (this as Success<T>).value : defaultValue;
}

class Success<T> extends Result<T> {
  final T value;
  Success(this.value);

  @override
  R fold<R>(R Function(Exception e) onError, R Function(T data) onSuccess) => onSuccess(value);
}

class Error<T> extends Result<T> {
  final Exception exception;
  Error(this.exception);

  @override
  R fold<R>(R Function(Exception e) onError, R Function(T data) onSuccess) => onError(exception);
}

Result<T> right<T>(T value) => Success<T>(value);
Result<T> left<T>(Exception exception) => Error<T>(exception);
