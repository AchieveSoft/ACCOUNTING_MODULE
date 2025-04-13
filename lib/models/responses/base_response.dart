class BaseResponse<T> {
  final bool success;
  final String message;
  final T? data;

  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    data: json['data'],
  );
}
