import 'dart:io';

HttpClient createHttpClient(SecurityContext? context) {
  HttpClient client = HttpClient(context: context);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  return client;
}
