import 'package:arch/common/dtos/http_response.dart';
import 'package:arch/common/interfaces/http_client.dart';
import 'package:dio/dio.dart';

class DioHttpClient implements IHttpClient {
  final Dio _dio;
  DioHttpClient(this._dio);

  @override
  Future<HttpResponse> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(url, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 200,
        statusMessage: response.statusMessage ?? '',
        data: response.data['data'],
      );
    } catch (e) {
      return HttpResponse(statusCode: 500, statusMessage: e.toString(), data: null);
    }
  }

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 200,
        statusMessage: response.statusMessage ?? '',
        data: response.data['data'],
      );
    } catch (e) {
      return HttpResponse(statusCode: 500, statusMessage: e.toString(), data: null);
    }
  }

  @override
  Future<HttpResponse> post(String url, {Map<String, String>? headers, body}) async {
    try {
      final response = await _dio.post(url, options: Options(headers: headers), data: body);
      return HttpResponse(
        statusCode: response.statusCode ?? 200,
        statusMessage: response.statusMessage ?? '',
        data: response.data['data'],
      );
    } catch (e) {
      return HttpResponse(statusCode: 500, statusMessage: e.toString(), data: null);
    }
  }

  @override
  Future<HttpResponse> put(String url, {Map<String, String>? headers, body}) async {
    try {
      final response = await _dio.put(url, options: Options(headers: headers), data: body);
      return HttpResponse(
        statusCode: response.statusCode ?? 200,
        statusMessage: response.statusMessage ?? '',
        data: response.data['data'],
      );
    } catch (e) {
      return HttpResponse(statusCode: 500, statusMessage: e.toString(), data: null);
    }
  }
}
