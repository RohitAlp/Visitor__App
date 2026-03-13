/// status : true
/// message : "Flat created successfully."
/// statusCode : 200
/// flatList : []

class AddFlatResponse {
  AddFlatResponse({
      bool? status, 
      String? message, 
      num? statusCode, 
      List<dynamic>? flatList,}){
    _status = status;
    _message = message;
    _statusCode = statusCode;
    _flatList = flatList;
}

  AddFlatResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['statusCode'];
    if (json['flatList'] != null) {
      _flatList = [];
     /* json['flatList'].forEach((v) {
        _flatList?.add(Dynamic.fromJson(v));
      });*/
    }
  }
  bool? _status;
  String? _message;
  num? _statusCode;
  List<dynamic>? _flatList;
AddFlatResponse copyWith({  bool? status,
  String? message,
  num? statusCode,
  List<dynamic>? flatList,
}) => AddFlatResponse(  status: status ?? _status,
  message: message ?? _message,
  statusCode: statusCode ?? _statusCode,
  flatList: flatList ?? _flatList,
);
  bool? get status => _status;
  String? get message => _message;
  num? get statusCode => _statusCode;
  List<dynamic>? get flatList => _flatList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    if (_flatList != null) {
      map['flatList'] = _flatList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}