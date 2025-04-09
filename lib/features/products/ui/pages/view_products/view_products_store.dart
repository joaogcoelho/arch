import 'package:arch/common/interfaces/use_case.dart';
import 'package:arch/common/stores/base_store.dart';
import 'package:arch/core/domain/dtos/product.dart';

class ViewProductsStore extends BaseStore {
  List<ProductDTO> products = [];

  final IUseCase<List<ProductDTO>> _findProductsUseCase;
  ViewProductsStore(this._findProductsUseCase);

  Future<void> findProducts() async {
    return runWithLoading(() async {
      var response = await _findProductsUseCase.execute();

      response.fold((error) {}, (products) {
        this.products = products;
        notifyListeners();
      });
    });
  }
}
