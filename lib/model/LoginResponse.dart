/// status : true
/// message : "OTP sent successfully"
/// otp : 123456

class LoginResponse {
  LoginResponse({
      bool? status, 
      String? message, 
      num? otp,}){
    _status = status;
    _message = message;
    _otp = otp;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _otp = json['otp'];
  }
  bool? _status;
  String? _message;
  num? _otp;
LoginResponse copyWith({  bool? status,
  String? message,
  num? otp,
}) => LoginResponse(  status: status ?? _status,
  message: message ?? _message,
  otp: otp ?? _otp,
);
  bool? get status => _status;
  String? get message => _message;
  num? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['otp'] = _otp;
    return map;
  }

}