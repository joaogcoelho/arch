import 'package:arch/common/interfaces/use_case.dart';
import 'package:arch/common/utils/result.dart';
import 'package:arch/common/utils/test.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_page.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arch/features/products/ui/widgets/card_product.dart';

class MockFindProductsUseCase implements IUseCase<List<ProductDTO>> {
  @override
  Future<Result<Exception, List<ProductDTO>>> execute() async {
    return Right([ProductDTO(id: 1, name: "Product 1"), ProductDTO(id: 2, name: "Product 2")]);
  }
}

void main() {
  var usecase = MockFindProductsUseCase();
  var store = ViewProductsStore(usecase);

  group('ViewProductsPage', () {
    testWidgets("Should render title and list of products", (tester) async {
      await tester.pumpWidgetMaterial(ViewProductsPage(searchProductsStore: store));

      var finder = tester.findText('View Products');
      expect(finder, findsOneWidget);

      finder = tester.findByType<CardProduct>();
      expect(finder, findsNWidgets(2));
    });
  });
}
