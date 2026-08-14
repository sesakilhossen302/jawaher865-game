class GeneralError {
  final String message;
  final int? statusCode;

  GeneralError({
    required this.message,
    this.statusCode,
  });

  factory GeneralError.fromJson(Map<String, dynamic> json) {
    return GeneralError(
      message: json['message'] ?? 'An error occurred',
      statusCode: json['statusCode'],
    );
  }

  @override
  String toString() => message;
}
