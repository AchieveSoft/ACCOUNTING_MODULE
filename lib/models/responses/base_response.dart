class BaseResponse<T> {
  final bool success;
  final String message;
  final T? data;

  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
  });
}
