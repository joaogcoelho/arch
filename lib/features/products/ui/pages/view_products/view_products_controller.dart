import 'package:arch/common/ui/base_controller.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/application/use_cases/find_products.dart';

class ViewProductsController extends BaseController {
  List<ProductDTO> products = [];

  final FindProductsUseCase _findProductsUseCase;
  ViewProductsController(this._findProductsUseCase);

  Future<void> findProducts() async {
    return runWithLoading(() async {
      var response = await _findProductsUseCase.execute(Teste(page: 1, actualPage: 1));

      response.fold((error) {}, (products) {
        this.products = products;
        notifyListeners();
      });
    });
  }
}
