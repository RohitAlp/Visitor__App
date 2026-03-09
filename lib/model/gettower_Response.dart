/// status : true
/// statusCode : 200
/// message : "Building list fetched successfully."
/// data : [{"buildingId":6,"buildingName":"siya","numberOfFloors":9,"societyId":3,"societyName":"ShreeRang Society"},{"buildingId":5,"buildingName":"Mittal Park ","numberOfFloors":9,"societyId":3,"societyName":"ShreeRang Society"},{"buildingId":4,"buildingName":"Aasha","numberOfFloors":9,"societyId":3,"societyName":"ShreeRang Society"},{"buildingId":1,"buildingName":"shraddha","numberOfFloors":5,"societyId":1,"societyName":"DevKrupa Society"}]

class GettowerController {
  GettowerController({
      bool? status, 
      num? statusCode, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  GettowerController.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  num? _statusCode;
  String? _message;
  List<Data>? _data;
GettowerController copyWith({  bool? status,
  num? statusCode,
  String? message,
  List<Data>? data,
}) => GettowerController(  status: status ?? _status,
  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  num? get statusCode => _statusCode;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// buildingId : 6
/// buildingName : "siya"
/// numberOfFloors : 9
/// societyId : 3
/// societyName : "ShreeRang Society"

class Data {
  Data({
      num? buildingId, 
      String? buildingName, 
      num? numberOfFloors, 
      num? societyId, 
      String? societyName,}){
    _buildingId = buildingId;
    _buildingName = buildingName;
    _numberOfFloors = numberOfFloors;
    _societyId = societyId;
    _societyName = societyName;
}

  Data.fromJson(dynamic json) {
    _buildingId = json['buildingId'];
    _buildingName = json['buildingName'];
    _numberOfFloors = json['numberOfFloors'];
    _societyId = json['societyId'];
    _societyName = json['societyName'];
  }
  num? _buildingId;
  String? _buildingName;
  num? _numberOfFloors;
  num? _societyId;
  String? _societyName;
Data copyWith({  num? buildingId,
  String? buildingName,
  num? numberOfFloors,
  num? societyId,
  String? societyName,
}) => Data(  buildingId: buildingId ?? _buildingId,
  buildingName: buildingName ?? _buildingName,
  numberOfFloors: numberOfFloors ?? _numberOfFloors,
  societyId: societyId ?? _societyId,
  societyName: societyName ?? _societyName,
);
  num? get buildingId => _buildingId;
  String? get buildingName => _buildingName;
  num? get numberOfFloors => _numberOfFloors;
  num? get societyId => _societyId;
  String? get societyName => _societyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buildingId'] = _buildingId;
    map['buildingName'] = _buildingName;
    map['numberOfFloors'] = _numberOfFloors;
    map['societyId'] = _societyId;
    map['societyName'] = _societyName;
    return map;
  }

}