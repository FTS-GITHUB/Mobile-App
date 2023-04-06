class ApiError {
  String? code;
  String? message;

  ApiError({this.code, this.message,});

  ApiError copyWith({String? code, String? message})=>ApiError(
    code: code?? this.code,
    message: message?? this.message,
  );

  ApiError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
