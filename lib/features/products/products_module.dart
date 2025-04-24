import 'package:arch/common/common_module.dart';
import 'package:arch/features/products/application/use_cases/find_products.dart';
import 'package:arch/features/products/ui/pages/new_product/new_product_page.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_page.dart';
import 'package:arch/features/products/ui/pages/view_products/view_products_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsModule extends Module {
  @override
  List<Module> get imports => [CommonModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(FindProductsUseCase.new);
    i.addLazySingleton(ViewProductsController.new);
  }

  @override
  void routes(RouteManager r) {
    r.add(
      ChildRoute(
        Modular.initialRoute,
        child:
            (context) =>
                ViewProductsPage(searchProductsController: Modular.get<ViewProductsController>()),
      ),
    );

    r.add(ChildRoute("/new_product/", child: (context) => NewProductPage()));
  }
}
