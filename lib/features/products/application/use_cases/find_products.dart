import 'package:arch/common/interfaces/http_client.dart';
import 'package:arch/common/interfaces/use_case.dart';
import 'package:arch/common/utils/result.dart';
import 'package:arch/core/domain/dtos/product.dart';

class FindProductsUseCase implements IUseCase<List<ProductDTO>> {
  final IHttpClient _httpClient;
  FindProductsUseCase(this._httpClient);

  @override
  Future<Result<Exception, List<ProductDTO>>> execute() async {
    final response = await _httpClient.get("/api/products");
    if (response.statusCode != 200) {
      return Left(Exception("Failed to load products"));
    }
    return Right(_parseResponse(response.data));
  }

  List<ProductDTO> _parseResponse(List<Map<String, dynamic>> response) {
    return response.map<ProductDTO>((product) => ProductDTO.fromJson(product)).toList();
  }
}
