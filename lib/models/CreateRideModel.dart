import 'dart:convert';
/// status : true
/// message : "Ride created"
/// ride_id : 5

CreateRideModel createRideModelFromJson(String str) => CreateRideModel.fromJson(json.decode(str));
String createRideModelToJson(CreateRideModel data) => json.encode(data.toJson());
class CreateRideModel {
  CreateRideModel({
      bool? status, 
      String? message, 
      String? rideId,}){
    _status = status;
    _message = message;
    _rideId = rideId;
}

  CreateRideModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _rideId = json['ride_id'];
  }
  bool? _status;
  String? _message;
  String? _rideId;
CreateRideModel copyWith({  bool? status,
  String? message,
  String? rideId,
}) => CreateRideModel(  status: status ?? _status,
  message: message ?? _message,
  rideId: rideId ?? _rideId,
);
  bool? get status => _status;
  String? get message => _message;
  String? get rideId => _rideId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['ride_id'] = _rideId;
    return map;
  }

}