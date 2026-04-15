typedef ApiPayloadParser<T> = T Function(dynamic payload);
typedef ApiPayloadResolver = dynamic Function(Map<String, dynamic> raw);

class ApiResponse<T> {
  const ApiResponse({
    required this.code,
    required this.message,
    required this.raw,
    this.data,
  });

  final int code;
  final String message;
  final T? data;
  final Map<String, dynamic> raw;

  bool get isSuccess => code == 1;
}
