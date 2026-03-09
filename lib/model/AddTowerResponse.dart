/// status : true
/// statusCode : 200
/// message : "Building created successfully."

class AddTowerResponse {
  AddTowerResponse({
      bool? status, 
      num? statusCode, 
      String? message,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
}

  AddTowerResponse.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
  }
  bool? _status;
  num? _statusCode;
  String? _message;
AddTowerResponse copyWith({  bool? status,
  num? statusCode,
  String? message,
}) => AddTowerResponse(  status: status ?? _status,
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