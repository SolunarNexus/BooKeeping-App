class UserNotLoggedInException implements Exception {
  String cause;

  UserNotLoggedInException(this.cause);
}
