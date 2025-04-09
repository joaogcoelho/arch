abstract class Result<L, R> {
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn);

  bool isLeft() => this is Left<L, R>;
  bool isRight() => this is Right<L, R>;
}

class Left<L, R> extends Result<L, R> {
  final L value;
  Left(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => leftFn(value);

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;
}

class Right<L, R> extends Result<L, R> {
  final R value;
  Right(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => rightFn(value);

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;
}
