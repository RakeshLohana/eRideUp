import 'dart:convert';
/// status : true
/// ride : {"id":"2","user_id":"14","pickup":"Live Location (20.44, 44.33)","drop":"Shah Faisal Colony Golimar Road Sukkur","status":"Not Requested","created_at":"2025-06-03 21:24:16","updated_at":"2025-06-03 21:24:16","pickup_lat":"20.44000000","pickup_lng":"44.33000000"}

GetRideDetails getRideDetailsFromJson(String str) => GetRideDetails.fromJson(json.decode(str));
String getRideDetailsToJson(GetRideDetails data) => json.encode(data.toJson());
class GetRideDetails {
  GetRideDetails({
      bool? status, 
      Ride? ride,}){
    _status = status;
    _ride = ride;
}

  GetRideDetails.fromJson(dynamic json) {
    _status = json['status'];
    _ride = json['ride'] != null ? Ride.fromJson(json['ride']) : null;
  }
  bool? _status;
  Ride? _ride;
GetRideDetails copyWith({  bool? status,
  Ride? ride,
}) => GetRideDetails(  status: status ?? _status,
  ride: ride ?? _ride,
);
  bool? get status => _status;
  Ride? get ride => _ride;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_ride != null) {
      map['ride'] = _ride?.toJson();
    }
    return map;
  }

}

/// id : "2"
/// user_id : "14"
/// pickup : "Live Location (20.44, 44.33)"
/// drop : "Shah Faisal Colony Golimar Road Sukkur"
/// status : "Not Requested"
/// created_at : "2025-06-03 21:24:16"
/// updated_at : "2025-06-03 21:24:16"
/// pickup_lat : "20.44000000"
/// pickup_lng : "44.33000000"

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
      String? pickupLng,}){
    _id = id;
    _userId = userId;
    _pickup = pickup;
    _drop = drop;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _pickupLat = pickupLat;
    _pickupLng = pickupLng;
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
Ride copyWith({  String? id,
  String? userId,
  String? pickup,
  String? drop,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? pickupLat,
  String? pickupLng,
}) => Ride(  id: id ?? _id,
  userId: userId ?? _userId,
  pickup: pickup ?? _pickup,
  drop: drop ?? _drop,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  pickupLat: pickupLat ?? _pickupLat,
  pickupLng: pickupLng ?? _pickupLng,
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
    return map;
  }

}