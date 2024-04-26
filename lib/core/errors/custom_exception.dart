class CustomException implements Exception {
  String _message = " ";

  CustomException(
      [String message = "Something went wrong, please try again!"]) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
