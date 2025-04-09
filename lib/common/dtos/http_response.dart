class HttpResponse {
  final int statusCode;
  final dynamic data;

  HttpResponse({required this.statusCode, required this.data});

  @override
  String toString() {
    return 'HttpResponse(statusCode: $statusCode, data: $data)';
  }
}
