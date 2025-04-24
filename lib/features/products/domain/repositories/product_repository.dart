import 'package:arch/common/utils/result.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/application/use_cases/find_products.dart';

abstract class IProductRepository {
  Future<Result<List<ProductDTO>>> findProducts(Teste props);
}
