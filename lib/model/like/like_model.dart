class LikeResponse {
  final int status;
  final String message;

  LikeResponse({required this.status, required this.message});

  factory LikeResponse.fromJson(Map<String, dynamic> json) {
    return LikeResponse(status: json['status'], message: json['message']);
  }
}
