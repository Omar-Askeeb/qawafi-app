import 'package:http/http.dart' as http;

class RangeHttpClient extends http.BaseClient {
  final http.Client _inner;

  RangeHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Add the range header to the request
    request.headers['Range'] = 'bytes=0-';
    return _inner.send(request);
  }
}
