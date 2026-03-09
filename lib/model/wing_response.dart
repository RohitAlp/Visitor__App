/// status : true
/// message : "Wing list fetched successfully."
/// statusCode : 200
/// wingList : [{"wingId":1,"wingName":"Wing 1B","buildingId":1,"buildingName":"shraddha","createdBy":0}]

class WingController {
  WingController({
    bool? status,
    String? message,
    num? statusCode,
    List<WingList>? wingList,}){
    _status = status;
    _message = message;
    _statusCode = statusCode;
    _wingList = wingList;
  }

  WingController.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['statusCode'];
    if (json['wingList'] != null) {
      _wingList = [];
      json['wingList'].forEach((v) {
        _wingList?.add(WingList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  num? _statusCode;
  List<WingList>? _wingList;
  WingController copyWith({  bool? status,
    String? message,
    num? statusCode,
    List<WingList>? wingList,
  }) => WingController(  status: status ?? _status,
    message: message ?? _message,
    statusCode: statusCode ?? _statusCode,
    wingList: wingList ?? _wingList,
  );
  bool? get status => _status;
  String? get message => _message;
  num? get statusCode => _statusCode;
  List<WingList>? get wingList => _wingList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    if (_wingList != null) {
      map['wingList'] = _wingList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// wingId : 1
/// wingName : "Wing 1B"
/// buildingId : 1
/// buildingName : "shraddha"
/// createdBy : 0

class WingList {
  WingList({
    num? wingId,
    String? wingName,
    num? buildingId,
    String? buildingName,
    num? createdBy,}){
    _wingId = wingId;
    _wingName = wingName;
    _buildingId = buildingId;
    _buildingName = buildingName;
    _createdBy = createdBy;
  }

  WingList.fromJson(dynamic json) {
    _wingId = json['wingId'];
    _wingName = json['wingName'];
    _buildingId = json['buildingId'];
    _buildingName = json['buildingName'];
    _createdBy = json['createdBy'];
  }
  num? _wingId;
  String? _wingName;
  num? _buildingId;
  String? _buildingName;
  num? _createdBy;
  WingList copyWith({  num? wingId,
    String? wingName,
    num? buildingId,
    String? buildingName,
    num? createdBy,
  }) => WingList(  wingId: wingId ?? _wingId,
    wingName: wingName ?? _wingName,
    buildingId: buildingId ?? _buildingId,
    buildingName: buildingName ?? _buildingName,
    createdBy: createdBy ?? _createdBy,
  );
  num? get wingId => _wingId;
  String? get wingName => _wingName;
  num? get buildingId => _buildingId;
  String? get buildingName => _buildingName;
  num? get createdBy => _createdBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wingId'] = _wingId;
    map['wingName'] = _wingName;
    map['buildingId'] = _buildingId;
    map['buildingName'] = _buildingName;
    map['createdBy'] = _createdBy;
    return map;
  }

}