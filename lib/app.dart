import 'package:arch/core/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class App {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      ModularApp(
        module: CoreModule(),
        child: MaterialApp.router(
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
