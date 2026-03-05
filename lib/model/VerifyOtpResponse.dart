/// status : true
/// message : "Login successful"
/// userId : 1
/// roleId : 1
/// roleName : "SuperAdmin"
/// fullName : "Sakshi Mhatre"
/// mobileNumber : "7770028773"
/// societyId : 0
/// societyName : null
/// buildingName : null
/// wingName : null
/// floorNumber : 0
/// flatNumber : 0
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxIiwiUm9sZUlkIjoiMSIsIlJvbGVOYW1lIjoiU3VwZXJBZG1pbiIsIlNvY2lldHlJZCI6IjAiLCJNb2JpbGVOdW1iZXIiOiI3NzcwMDI4NzczIiwiZXhwIjoxNzcyNzExODU3LCJpc3MiOiJTTVNCYWNrZW5kIiwiYXVkIjoiU01TQmFja2VuZFVzZXJzIn0.x1HCDlydZ7vT-zI_l3p47IBWVy6DutUYWx6ZieG6_cU"

class VerifyOtpResponse {
  VerifyOtpResponse({
      bool? status, 
      String? message, 
      num? userId, 
      num? roleId, 
      String? roleName, 
      String? fullName, 
      String? mobileNumber, 
      num? societyId, 
      dynamic societyName, 
      dynamic buildingName, 
      dynamic wingName, 
      num? floorNumber, 
      num? flatNumber, 
      String? token,}){
    _status = status;
    _message = message;
    _userId = userId;
    _roleId = roleId;
    _roleName = roleName;
    _fullName = fullName;
    _mobileNumber = mobileNumber;
    _societyId = societyId;
    _societyName = societyName;
    _buildingName = buildingName;
    _wingName = wingName;
    _floorNumber = floorNumber;
    _flatNumber = flatNumber;
    _token = token;
}

  VerifyOtpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userId = json['userId'];
    _roleId = json['roleId'];
    _roleName = json['roleName'];
    _fullName = json['fullName'];
    _mobileNumber = json['mobileNumber'];
    _societyId = json['societyId'];
    _societyName = json['societyName'];
    _buildingName = json['buildingName'];
    _wingName = json['wingName'];
    _floorNumber = json['floorNumber'];
    _flatNumber = json['flatNumber'];
    _token = json['token'];
  }
  bool? _status;
  String? _message;
  num? _userId;
  num? _roleId;
  String? _roleName;
  String? _fullName;
  String? _mobileNumber;
  num? _societyId;
  dynamic _societyName;
  dynamic _buildingName;
  dynamic _wingName;
  num? _floorNumber;
  num? _flatNumber;
  String? _token;
VerifyOtpResponse copyWith({  bool? status,
  String? message,
  num? userId,
  num? roleId,
  String? roleName,
  String? fullName,
  String? mobileNumber,
  num? societyId,
  dynamic societyName,
  dynamic buildingName,
  dynamic wingName,
  num? floorNumber,
  num? flatNumber,
  String? token,
}) => VerifyOtpResponse(  status: status ?? _status,
  message: message ?? _message,
  userId: userId ?? _userId,
  roleId: roleId ?? _roleId,
  roleName: roleName ?? _roleName,
  fullName: fullName ?? _fullName,
  mobileNumber: mobileNumber ?? _mobileNumber,
  societyId: societyId ?? _societyId,
  societyName: societyName ?? _societyName,
  buildingName: buildingName ?? _buildingName,
  wingName: wingName ?? _wingName,
  floorNumber: floorNumber ?? _floorNumber,
  flatNumber: flatNumber ?? _flatNumber,
  token: token ?? _token,
);
  bool? get status => _status;
  String? get message => _message;
  num? get userId => _userId;
  num? get roleId => _roleId;
  String? get roleName => _roleName;
  String? get fullName => _fullName;
  String? get mobileNumber => _mobileNumber;
  num? get societyId => _societyId;
  dynamic get societyName => _societyName;
  dynamic get buildingName => _buildingName;
  dynamic get wingName => _wingName;
  num? get floorNumber => _floorNumber;
  num? get flatNumber => _flatNumber;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['userId'] = _userId;
    map['roleId'] = _roleId;
    map['roleName'] = _roleName;
    map['fullName'] = _fullName;
    map['mobileNumber'] = _mobileNumber;
    map['societyId'] = _societyId;
    map['societyName'] = _societyName;
    map['buildingName'] = _buildingName;
    map['wingName'] = _wingName;
    map['floorNumber'] = _floorNumber;
    map['flatNumber'] = _flatNumber;
    map['token'] = _token;
    return map;
  }

}