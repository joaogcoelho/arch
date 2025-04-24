import 'package:arch/common/utils/result.dart';
import 'package:arch/common/utils/test.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/application/use_cases/find_products.dart';
import 'package:arch/features/products/domain/repositories/product_repository.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_page.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arch/features/products/ui/widgets/card_product.dart';

class MockProductRepository extends GenericMockService implements IProductRepository {}

void main() {
  List<ProductDTO> mockProducts = [
    ProductDTO(id: 1, name: 'Product 1'),
    ProductDTO(id: 2, name: 'Product 2'),
  ];

  late ViewProductsController controller;
  late FindProductsUseCase usecase;
  late MockProductRepository repository;

  setUpAll(() {
    repository = MockProductRepository();

    repository.mockHandler.returnOnce(
      "findProducts",
      () async => right<List<ProductDTO>>([]),
      validator: (dynamic param) {
        return param.page == 1;
      },
    );
    repository.mockHandler.returnOnce("findProducts", () async => right(mockProducts));

    usecase = FindProductsUseCase(repository);
  });

  setUp(() {
    controller = ViewProductsController(usecase);
  });

  group('ViewProductsPage', () {
    testWidgets("Should show products on success", (tester) async {
      await tester.pumpWidgetMaterial(ViewProductsPage(searchProductsController: controller));
      expect(tester.findByType<CardProduct>(), findsNWidgets(0));
    });

    testWidgets("Should show products on success", (tester) async {
      await tester.pumpWidgetMaterial(ViewProductsPage(searchProductsController: controller));
      expect(tester.findByType<CardProduct>(), findsNWidgets(2));
    });
  });
}
