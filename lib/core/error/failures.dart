class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occurred']);
}

class ConflictFailure extends Failure {
  ConflictFailure(String message) : super(message);
}
