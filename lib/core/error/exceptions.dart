// class ServerException implements Exception {
//   final String message;
//   const ServerException(this.message);
// }

class ServerException implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  FetchDataException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "خطأ أثناء التواصل");
}

class EmptyResponseException extends ServerException {
  EmptyResponseException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "لا يوجد بيانات أو محتوى متاح");
}

class BadRequestException extends ServerException {
  BadRequestException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "طلب غير صالح");
}

class BadResponseException extends ServerException {
  BadResponseException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "استجابة غير صالحة");
}

class UnauthorizedException extends ServerException {
  UnauthorizedException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "غير مصرح به");
}

class NotFoundException extends ServerException {
  NotFoundException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "المعلومات المطلوبة غير موجودة");
}

class ConflictException extends ServerException {
  ConflictException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "حدث تضارب");
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "خطأ داخلي في الخادم");
}

class TooManyRequests extends ServerException {
  TooManyRequests([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "لقد أرسلت عددًا كبيرًا جدًا من الطلبات في وقت قصير. يُرجى المحاولة مرة أخرى لاحقًا.");
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "لا يوجد اتصال بالإنترنت");
}

class CacheException extends ServerException {
  CacheException([message])
      : super((message != null && message.toString().isNotEmpty)
            ? message.toString()
            : "لا يوجد بيانات أو محتوى متاح");
}
