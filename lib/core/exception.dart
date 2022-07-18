class CustomException implements Exception {
  final String? message;
  final int? code;
  final dynamic data;

  CustomException({
    this.message,
    this.code,
    this.data,
  });

  @override
  String toString() {
    if ((message ?? "").trim().isEmpty) return "Unknown error";
    return message ?? "";
  }
}

class CustomExceptionUnauthorized extends CustomException {
  CustomExceptionUnauthorized({String? message, dynamic data})
      : super(
          code: 401,
          message: message,
          data: data,
        );
}
