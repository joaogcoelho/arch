import 'package:arch/common/interfaces/http_client.dart';
import 'package:arch/common/utils/result.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/application/use_cases/find_products.dart';
import 'package:arch/features/products/domain/repositories/product_repository.dart';

class ApiProductRepository implements IProductRepository {
  final IHttpClient httpClient;
  ApiProductRepository(this.httpClient);

  @override
  Future<Result<List<ProductDTO>>> findProducts(Teste props) async {
    var response = await httpClient.get('/products');

    if (response.statusCode != 200) {
      return left(Exception('unable to fetch products, status code: ${response.statusCode}'));
    }

    if (response.data! is List) {
      return left(Exception('unable to fetch products, invalid format of response'));
    }

    return right(response.data.map((json) => ProductDTO.fromJson(json)).toList());
  }
}
