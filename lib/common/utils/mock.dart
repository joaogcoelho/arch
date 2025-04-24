import 'package:arch/features/products/application/use_cases/find_products.dart';
import 'package:arch/features/products/domain/repositories/product_repository.dart';

class MockMethodHandler {
  T call<T>(String methodName, [dynamic params]) {
    print('======');
    print(methodName);
    print(params);
    print('======');
    return {} as T;
  }
}

abstract class Mock {
  final _mockHandler = MockMethodHandler();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final name = _getMethodName(invocation.memberName);
    return _mockHandler.call(name, invocation.positionalArguments);
  }

  String _getMethodName(Symbol symbol) {
    return symbol.toString().replaceAll("Symbol(\"", "").replaceAll("\")", "");
  }
}

class MockRepo extends Mock implements IProductRepository {}

void main() {
  var repo = MockRepo();

  repo.findProducts(Teste(page: 1, actualPage: 1));
}
