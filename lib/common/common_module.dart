import 'package:arch/common/adapters/dio.dart';
import 'package:arch/common/interfaces/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommonModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<Dio>(() => Dio(BaseOptions(baseUrl: "http://localhost:3030")));
    i.addSingleton<IHttpClient>(() => DioHttpClient(i.get<Dio>()));
  }
}
