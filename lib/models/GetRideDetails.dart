import 'dart:convert';
/// status : true
/// ride : {"id":"9","user_id":"14","pickup":"Live Location (37.4219983, -122.084)","drop":"Shah Faisal Colony Golimar Road Sukkur","status":"Not Requested","created_at":"2025-06-27 18:27:54","updated_at":"2025-07-02 19:15:40","pickup_lat":"37.42199830","pickup_lng":"-122.08400000","otp":"123","arriving_time":"15","amount_cover":"50","amount_you_pay":"12","drop_lat":null,"drop_lng":null}
/// ride_label : "RIDE-9"

GetRideDetails getRideDetailsFromJson(String str) => GetRideDetails.fromJson(json.decode(str));
String getRideDetailsToJson(GetRideDetails data) => json.encode(data.toJson());
class GetRideDetails {
  GetRideDetails({
      bool? status, 
      Ride? ride, 
      String? rideLabel,}){
    _status = status;
    _ride = ride;
    _rideLabel = rideLabel;
}

  GetRideDetails.fromJson(dynamic json) {
    _status = json['status'];
    _ride = json['ride'] != null ? Ride.fromJson(json['ride']) : null;
    _rideLabel = json['ride_label'];
  }
  bool? _status;
  Ride? _ride;
  String? _rideLabel;
GetRideDetails copyWith({  bool? status,
  Ride? ride,
  String? rideLabel,
}) => GetRideDetails(  status: status ?? _status,
  ride: ride ?? _ride,
  rideLabel: rideLabel ?? _rideLabel,
);
  bool? get status => _status;
  Ride? get ride => _ride;
  String? get rideLabel => _rideLabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_ride != null) {
      map['ride'] = _ride?.toJson();
    }
    map['ride_label'] = _rideLabel;
    return map;
  }

}

/// id : "9"
/// user_id : "14"
/// pickup : "Live Location (37.4219983, -122.084)"
/// drop : "Shah Faisal Colony Golimar Road Sukkur"
/// status : "Not Requested"
/// created_at : "2025-06-27 18:27:54"
/// updated_at : "2025-07-02 19:15:40"
/// pickup_lat : "37.42199830"
/// pickup_lng : "-122.08400000"
/// otp : "123"
/// arriving_time : "15"
/// amount_cover : "50"
/// amount_you_pay : "12"
/// drop_lat : null
/// drop_lng : null

Ride rideFromJson(String str) => Ride.fromJson(json.decode(str));
String rideToJson(Ride data) => json.encode(data.toJson());
class Ride {
  Ride({
      String? id, 
      String? userId, 
      String? pickup, 
      String? drop, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? pickupLat, 
      String? pickupLng, 
      String? otp, 
      String? arrivingTime, 
      String? amountCover, 
      String? amountYouPay, 
      dynamic dropLat, 
      dynamic dropLng,}){
    _id = id;
    _userId = userId;
    _pickup = pickup;
    _drop = drop;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _pickupLat = pickupLat;
    _pickupLng = pickupLng;
    _otp = otp;
    _arrivingTime = arrivingTime;
    _amountCover = amountCover;
    _amountYouPay = amountYouPay;
    _dropLat = dropLat;
    _dropLng = dropLng;
}

  Ride.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _pickup = json['pickup'];
    _drop = json['drop'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _pickupLat = json['pickup_lat'];
    _pickupLng = json['pickup_lng'];
    _otp = json['otp'];
    _arrivingTime = json['arriving_time'];
    _amountCover = json['amount_cover'];
    _amountYouPay = json['amount_you_pay'];
    _dropLat = json['drop_lat'];
    _dropLng = json['drop_lng'];
  }
  String? _id;
  String? _userId;
  String? _pickup;
  String? _drop;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _pickupLat;
  String? _pickupLng;
  String? _otp;
  String? _arrivingTime;
  String? _amountCover;
  String? _amountYouPay;
  dynamic _dropLat;
  dynamic _dropLng;
Ride copyWith({  String? id,
  String? userId,
  String? pickup,
  String? drop,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? pickupLat,
  String? pickupLng,
  String? otp,
  String? arrivingTime,
  String? amountCover,
  String? amountYouPay,
  dynamic dropLat,
  dynamic dropLng,
}) => Ride(  id: id ?? _id,
  userId: userId ?? _userId,
  pickup: pickup ?? _pickup,
  drop: drop ?? _drop,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  pickupLat: pickupLat ?? _pickupLat,
  pickupLng: pickupLng ?? _pickupLng,
  otp: otp ?? _otp,
  arrivingTime: arrivingTime ?? _arrivingTime,
  amountCover: amountCover ?? _amountCover,
  amountYouPay: amountYouPay ?? _amountYouPay,
  dropLat: dropLat ?? _dropLat,
  dropLng: dropLng ?? _dropLng,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get pickup => _pickup;
  String? get drop => _drop;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get pickupLat => _pickupLat;
  String? get pickupLng => _pickupLng;
  String? get otp => _otp;
  String? get arrivingTime => _arrivingTime;
  String? get amountCover => _amountCover;
  String? get amountYouPay => _amountYouPay;
  dynamic get dropLat => _dropLat;
  dynamic get dropLng => _dropLng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['pickup'] = _pickup;
    map['drop'] = _drop;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['pickup_lat'] = _pickupLat;
    map['pickup_lng'] = _pickupLng;
    map['otp'] = _otp;
    map['arriving_time'] = _arrivingTime;
    map['amount_cover'] = _amountCover;
    map['amount_you_pay'] = _amountYouPay;
    map['drop_lat'] = _dropLat;
    map['drop_lng'] = _dropLng;
    return map;
  }

}