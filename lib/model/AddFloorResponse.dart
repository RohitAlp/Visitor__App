/// success : true
/// message : "Floor created successfully."
/// statusCode : 200
/// floorList : null

class AddFloorResponse {
  AddFloorResponse({
      bool? success, 
      String? message, 
      num? statusCode, 
      dynamic floorList,}){
    _success = success;
    _message = message;
    _statusCode = statusCode;
    _floorList = floorList;
}

  AddFloorResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _statusCode = json['statusCode'];
    _floorList = json['floorList'];
  }
  bool? _success;
  String? _message;
  num? _statusCode;
  dynamic _floorList;
AddFloorResponse copyWith({  bool? success,
  String? message,
  num? statusCode,
  dynamic floorList,
}) => AddFloorResponse(  success: success ?? _success,
  message: message ?? _message,
  statusCode: statusCode ?? _statusCode,
  floorList: floorList ?? _floorList,
);
  bool? get success => _success;
  String? get message => _message;
  num? get statusCode => _statusCode;
  dynamic get floorList => _floorList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    map['floorList'] = _floorList;
    return map;
  }

}