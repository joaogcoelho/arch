import 'package:arch/features/products/products_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void routes(RouteManager r) {
    r.add(ModuleRoute(Modular.initialRoute, module: ProductsModule()));
  }
}
