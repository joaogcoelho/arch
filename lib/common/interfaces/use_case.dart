import 'package:arch/common/utils/result.dart';

abstract interface class IUseCaseWithParam<P, R> {
  Future<Result<Exception, R>> execute(P params);
}

abstract interface class IUseCase<R> {
  Future<Result<Exception, R>> execute();
}
