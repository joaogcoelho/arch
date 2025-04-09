class HttpResponse {
  final int statusCode;
  final String statusMessage;
  final dynamic data;

  HttpResponse({required this.statusCode, required this.statusMessage, required this.data});

  @override
  String toString() {
    return 'HttpResponse(statusCode: $statusCode, statusMessage: $statusMessage, data: $data)';
  }
}
