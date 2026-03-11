/// status : true
/// statusCode : 200
/// message : "Wing created successfully."

class AddWingResponse {
  AddWingResponse({
      bool? status, 
      num? statusCode, 
      String? message,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
}

  AddWingResponse.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
  }
  bool? _status;
  num? _statusCode;
  String? _message;
AddWingResponse copyWith({  bool? status,
  num? statusCode,
  String? message,
}) => AddWingResponse(  status: status ?? _status,
  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
);
  bool? get status => _status;
  num? get statusCode => _statusCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    return map;
  }

}