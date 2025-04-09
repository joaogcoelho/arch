import 'package:arch/common/dtos/http_response.dart';
import 'package:arch/common/interfaces/http_client.dart';
import 'package:dio/dio.dart';

class DioHttpClient implements IHttpClient {
  final Dio _dio;
  DioHttpClient(this._dio) {
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status < 500;
    };
  }

  @override
  Future<HttpResponse> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(url, options: Options(headers: headers));
      return HttpResponse(statusCode: response.statusCode!, data: response.data['data']);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return HttpResponse(statusCode: response.statusCode!, data: response.data['data']);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> post(String url, {Map<String, String>? headers, body}) async {
    try {
      final response = await _dio.post(url, options: Options(headers: headers), data: body);
      return HttpResponse(statusCode: response.statusCode!, data: response.data['data']);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpResponse> put(String url, {Map<String, String>? headers, body}) async {
    try {
      final response = await _dio.put(url, options: Options(headers: headers), data: body);
      return HttpResponse(statusCode: response.statusCode!, data: response.data['data']);
    } catch (e) {
      return _handleError(e);
    }
  }

  HttpResponse _handleError(Object error) {
    var statusCode = 500;
    dynamic data;
    if (error is DioException) {
      statusCode = error.response?.statusCode ?? 500;
      data = error.response?.data['data'];
    }

    return HttpResponse(statusCode: statusCode, data: data);
  }
}
