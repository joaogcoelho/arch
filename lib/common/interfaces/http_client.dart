import 'package:arch/common/dtos/http_response.dart';

abstract interface class IHttpClient {
  Future<HttpResponse> get(String url, {Map<String, String>? headers});
  Future<HttpResponse> post(String url, {Map<String, String>? headers, dynamic body});
  Future<HttpResponse> put(String url, {Map<String, String>? headers, dynamic body});
  Future<HttpResponse> delete(String url, {Map<String, String>? headers});
}
