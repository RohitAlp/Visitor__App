/// status : true
/// message : "Society list fetched successfully."
/// statusCode : 200
/// societyList : [{"societyId":6,"societyName":"Arihandt society","registrationNo":"Reg9008","address":"Kalwa","state":"Maharashtra","city":"Thane","pinCode":"400006","contact":"9881890989","email":"ari@gmail.com","taxNumber":"Tax9007"},{"societyId":3,"societyName":"ShreeRang Society","registrationNo":"Reg 1009","address":"Shreerang","state":"Maharashtra","city":"Thane","pinCode":"400601","contact":"9880908765","email":"shree@gmail.com","taxNumber":"TAX9006"},{"societyId":1,"societyName":"DevKrupa Society","registrationNo":"NO9008","address":"Near Shreeji Tower","state":"Maharashtra","city":"Thane","pinCode":"400006","contact":"7770028773","email":"sakshimhatre21.alphonsol@gmail.com","taxNumber":"Tax9009"}]

class GetSocietyResponse {
  GetSocietyResponse({
      bool? status, 
      String? message, 
      num? statusCode, 
      List<SocietyList>? societyList,}){
    _status = status;
    _message = message;
    _statusCode = statusCode;
    _societyList = societyList;
}

  GetSocietyResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['statusCode'];
    if (json['societyList'] != null) {
      _societyList = [];
      json['societyList'].forEach((v) {
        _societyList?.add(SocietyList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  num? _statusCode;
  List<SocietyList>? _societyList;
GetSocietyResponse copyWith({  bool? status,
  String? message,
  num? statusCode,
  List<SocietyList>? societyList,
}) => GetSocietyResponse(  status: status ?? _status,
  message: message ?? _message,
  statusCode: statusCode ?? _statusCode,
  societyList: societyList ?? _societyList,
);
  bool? get status => _status;
  String? get message => _message;
  num? get statusCode => _statusCode;
  List<SocietyList>? get societyList => _societyList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    if (_societyList != null) {
      map['societyList'] = _societyList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// societyId : 6
/// societyName : "Arihandt society"
/// registrationNo : "Reg9008"
/// address : "Kalwa"
/// state : "Maharashtra"
/// city : "Thane"
/// pinCode : "400006"
/// contact : "9881890989"
/// email : "ari@gmail.com"
/// taxNumber : "Tax9007"

class SocietyList {
  SocietyList({
      num? societyId, 
      String? societyName, 
      String? registrationNo, 
      String? address, 
      String? state, 
      String? city, 
      String? pinCode, 
      String? contact, 
      String? email, 
      String? taxNumber,}){
    _societyId = societyId;
    _societyName = societyName;
    _registrationNo = registrationNo;
    _address = address;
    _state = state;
    _city = city;
    _pinCode = pinCode;
    _contact = contact;
    _email = email;
    _taxNumber = taxNumber;
}

  SocietyList.fromJson(dynamic json) {
    _societyId = json['societyId'];
    _societyName = json['societyName'];
    _registrationNo = json['registrationNo'];
    _address = json['address'];
    _state = json['state'];
    _city = json['city'];
    _pinCode = json['pinCode'];
    _contact = json['contact'];
    _email = json['email'];
    _taxNumber = json['taxNumber'];
  }
  num? _societyId;
  String? _societyName;
  String? _registrationNo;
  String? _address;
  String? _state;
  String? _city;
  String? _pinCode;
  String? _contact;
  String? _email;
  String? _taxNumber;
SocietyList copyWith({  num? societyId,
  String? societyName,
  String? registrationNo,
  String? address,
  String? state,
  String? city,
  String? pinCode,
  String? contact,
  String? email,
  String? taxNumber,
}) => SocietyList(  societyId: societyId ?? _societyId,
  societyName: societyName ?? _societyName,
  registrationNo: registrationNo ?? _registrationNo,
  address: address ?? _address,
  state: state ?? _state,
  city: city ?? _city,
  pinCode: pinCode ?? _pinCode,
  contact: contact ?? _contact,
  email: email ?? _email,
  taxNumber: taxNumber ?? _taxNumber,
);
  num? get societyId => _societyId;
  String? get societyName => _societyName;
  String? get registrationNo => _registrationNo;
  String? get address => _address;
  String? get state => _state;
  String? get city => _city;
  String? get pinCode => _pinCode;
  String? get contact => _contact;
  String? get email => _email;
  String? get taxNumber => _taxNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['societyId'] = _societyId;
    map['societyName'] = _societyName;
    map['registrationNo'] = _registrationNo;
    map['address'] = _address;
    map['state'] = _state;
    map['city'] = _city;
    map['pinCode'] = _pinCode;
    map['contact'] = _contact;
    map['email'] = _email;
    map['taxNumber'] = _taxNumber;
    return map;
  }

}