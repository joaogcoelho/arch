import 'package:arch/common/utils/result.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/domain/repositories/product_repository.dart';

class FindProductsUseCase {
  final IProductRepository _productsRepository;
  FindProductsUseCase(this._productsRepository);

  Future<Result<List<ProductDTO>>> execute(Teste props) {
    return _productsRepository.findProducts(props);
  }
}

class Teste {
  int page;
  int actualPage;
  String name;

  Teste({required this.page, required this.actualPage, this.name = "ass"});
}

class TesteDTO {
  int page;
  int actualPage;
  String name;

  TesteDTO({required this.page, required this.actualPage, this.name = "ass"});
}
