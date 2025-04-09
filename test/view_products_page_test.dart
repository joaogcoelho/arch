import 'package:arch/common/interfaces/use_case.dart';
import 'package:arch/common/utils/result.dart';
import 'package:arch/common/utils/test.dart';
import 'package:arch/core/domain/dtos/product.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_page.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arch/features/products/ui/widgets/card_product.dart';

class MockFindProductsUseCase implements IUseCase<List<ProductDTO>> {
  final mockResponse = MockResult<List<ProductDTO>>();

  @override
  Future<Result<Exception, List<ProductDTO>>> execute() async {
    return mockResponse.next();
  }
}

void main() {
  var usecase = MockFindProductsUseCase();
  late ViewProductsStore store;

  setUpAll(() {
    usecase.mockResponse
        .returnOnce(Right([]))
        .returnOnce(
          Right([ProductDTO(id: 1, name: 'Product 1'), ProductDTO(id: 2, name: 'Product 2')]),
        );
  });

  setUp(() {
    store = ViewProductsStore(usecase);
  });

  group('ViewProductsPage', () {
    testWidgets("Should show products on success", (tester) async {
      await tester.pumpWidget(MaterialApp(home: ViewProductsPage(searchProductsStore: store)));
      await tester.pumpAndSettle();
      await tester.pump();
      expect(tester.findByType<CardProduct>(), findsNWidgets(0));
    });

    testWidgets("Should show products on success", (tester) async {
      await tester.pumpWidget(MaterialApp(home: ViewProductsPage(searchProductsStore: store)));
      await tester.pumpAndSettle();
      await tester.pump();
      expect(tester.findByType<CardProduct>(), findsNWidgets(2));
    });
  });
}
