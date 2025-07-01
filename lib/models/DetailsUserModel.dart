import 'dart:convert';
/// status : true
/// message : "Details Fetch"
/// customer : {"id":"1","name":"Aftab Hussain","email":"a03003132335@gmail.com","phone":"03133473749","address":"dummy","city":"Karachi","state":"Sindh","country":"Pakistan","postal_code":"9200","date_of_birth":"2025-05-15","gender":"male","profile_image":"https://innsurance.flash-speed.online/","status":"1","isDeleted":"0","createdBy":"-1","createdDtm":"2025-05-08 19:50:40","updatedBy":"15","updatedDtm":"2025-05-31 21:08:02","total_rides":null,"used_rides":null,"remaining_rides":null,"contact_number":"1111111111111","insurance_plan":[{"duration":" $15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"},{"duration":" $15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"}],"rides":[{"date":"2025-05-20","time":"10:00 AM","ride_id":"RIDE001","pickup":"Main Street","drop":"Park Avenue","status":"Completed"},{"date":"2025-05-22","time":"02:00 PM","ride_id":"RIDE002","pickup":"Central Mall","drop":"Greenwood Plaza","status":"Ongoing"},{"date":"2025-05-25","time":"04:00 PM","ride_id":"RIDE003","pickup":"Sunset Boulevard","drop":"Hillview Road","status":"Not Requested"}]}

DetailsUserModel detailsUserModelFromJson(String str) => DetailsUserModel.fromJson(json.decode(str));
String detailsUserModelToJson(DetailsUserModel data) => json.encode(data.toJson());
class DetailsUserModel {
  DetailsUserModel({
      bool? status, 
      String? message, 
      Customer? customer,}){
    _status = status;
    _message = message;
    _customer = customer;
}

  DetailsUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  bool? _status;
  String? _message;
  Customer? _customer;
DetailsUserModel copyWith({  bool? status,
  String? message,
  Customer? customer,
}) => DetailsUserModel(  status: status ?? _status,
  message: message ?? _message,
  customer: customer ?? _customer,
);
  bool? get status => _status;
  String? get message => _message;
  Customer? get customer => _customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// name : "Aftab Hussain"
/// email : "a03003132335@gmail.com"
/// phone : "03133473749"
/// address : "dummy"
/// city : "Karachi"
/// state : "Sindh"
/// country : "Pakistan"
/// postal_code : "9200"
/// date_of_birth : "2025-05-15"
/// gender : "male"
/// profile_image : "https://innsurance.flash-speed.online/"
/// status : "1"
/// isDeleted : "0"
/// createdBy : "-1"
/// createdDtm : "2025-05-08 19:50:40"
/// updatedBy : "15"
/// updatedDtm : "2025-05-31 21:08:02"
/// total_rides : null
/// used_rides : null
/// remaining_rides : null
/// contact_number : "1111111111111"
/// insurance_plan : [{"duration":" $15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"},{"duration":" $15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"}]
/// rides : [{"date":"2025-05-20","time":"10:00 AM","ride_id":"RIDE001","pickup":"Main Street","drop":"Park Avenue","status":"Completed"},{"date":"2025-05-22","time":"02:00 PM","ride_id":"RIDE002","pickup":"Central Mall","drop":"Greenwood Plaza","status":"Ongoing"},{"date":"2025-05-25","time":"04:00 PM","ride_id":"RIDE003","pickup":"Sunset Boulevard","drop":"Hillview Road","status":"Not Requested"}]

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());
class Customer {
  Customer({
      String? id, 
      String? name, 
      String? email, 
      String? phone, 
      String? address, 
      String? city, 
      String? state, 
      String? country, 
      String? postalCode, 
      String? dateOfBirth, 
      String? gender, 
      String? profileImage, 
      String? status, 
      String? isDeleted, 
      String? createdBy, 
      String? createdDtm, 
      String? updatedBy, 
      String? updatedDtm, 
      dynamic totalRides, 
      dynamic usedRides, 
      dynamic remainingRides, 
      String? contactNumber, 
      List<InsurancePlan>? insurancePlan, 
      List<Rides>? rides,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _address = address;
    _city = city;
    _state = state;
    _country = country;
    _postalCode = postalCode;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _profileImage = profileImage;
    _status = status;
    _isDeleted = isDeleted;
    _createdBy = createdBy;
    _createdDtm = createdDtm;
    _updatedBy = updatedBy;
    _updatedDtm = updatedDtm;
    _totalRides = totalRides;
    _usedRides = usedRides;
    _remainingRides = remainingRides;
    _contactNumber = contactNumber;
    _insurancePlan = insurancePlan;
    _rides = rides;
}

  Customer.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _postalCode = json['postal_code'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _profileImage = json['profile_image'];
    _status = json['status'];
    _isDeleted = json['isDeleted'];
    _createdBy = json['createdBy'];
    _createdDtm = json['createdDtm'];
    _updatedBy = json['updatedBy'];
    _updatedDtm = json['updatedDtm'];
    _totalRides = json['total_rides'];
    _usedRides = json['used_rides'];
    _remainingRides = json['remaining_rides'];
    _contactNumber = json['contact_number'];
    if (json['insurance_plan'] != null) {
      _insurancePlan = [];
      json['insurance_plan'].forEach((v) {
        _insurancePlan?.add(InsurancePlan.fromJson(v));
      });
    }
    if (json['rides'] != null) {
      _rides = [];
      json['rides'].forEach((v) {
        _rides?.add(Rides.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  String? _city;
  String? _state;
  String? _country;
  String? _postalCode;
  String? _dateOfBirth;
  String? _gender;
  String? _profileImage;
  String? _status;
  String? _isDeleted;
  String? _createdBy;
  String? _createdDtm;
  String? _updatedBy;
  String? _updatedDtm;
  dynamic _totalRides;
  dynamic _usedRides;
  dynamic _remainingRides;
  String? _contactNumber;
  List<InsurancePlan>? _insurancePlan;
  List<Rides>? _rides;
Customer copyWith({  String? id,
  String? name,
  String? email,
  String? phone,
  String? address,
  String? city,
  String? state,
  String? country,
  String? postalCode,
  String? dateOfBirth,
  String? gender,
  String? profileImage,
  String? status,
  String? isDeleted,
  String? createdBy,
  String? createdDtm,
  String? updatedBy,
  String? updatedDtm,
  dynamic totalRides,
  dynamic usedRides,
  dynamic remainingRides,
  String? contactNumber,
  List<InsurancePlan>? insurancePlan,
  List<Rides>? rides,
}) => Customer(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  postalCode: postalCode ?? _postalCode,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  profileImage: profileImage ?? _profileImage,
  status: status ?? _status,
  isDeleted: isDeleted ?? _isDeleted,
  createdBy: createdBy ?? _createdBy,
  createdDtm: createdDtm ?? _createdDtm,
  updatedBy: updatedBy ?? _updatedBy,
  updatedDtm: updatedDtm ?? _updatedDtm,
  totalRides: totalRides ?? _totalRides,
  usedRides: usedRides ?? _usedRides,
  remainingRides: remainingRides ?? _remainingRides,
  contactNumber: contactNumber ?? _contactNumber,
  insurancePlan: insurancePlan ?? _insurancePlan,
  rides: rides ?? _rides,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get postalCode => _postalCode;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get profileImage => _profileImage;
  String? get status => _status;
  String? get isDeleted => _isDeleted;
  String? get createdBy => _createdBy;
  String? get createdDtm => _createdDtm;
  String? get updatedBy => _updatedBy;
  String? get updatedDtm => _updatedDtm;
  dynamic get totalRides => _totalRides;
  dynamic get usedRides => _usedRides;
  dynamic get remainingRides => _remainingRides;
  String? get contactNumber => _contactNumber;
  List<InsurancePlan>? get insurancePlan => _insurancePlan;
  List<Rides>? get rides => _rides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['postal_code'] = _postalCode;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['profile_image'] = _profileImage;
    map['status'] = _status;
    map['isDeleted'] = _isDeleted;
    map['createdBy'] = _createdBy;
    map['createdDtm'] = _createdDtm;
    map['updatedBy'] = _updatedBy;
    map['updatedDtm'] = _updatedDtm;
    map['total_rides'] = _totalRides;
    map['used_rides'] = _usedRides;
    map['remaining_rides'] = _remainingRides;
    map['contact_number'] = _contactNumber;
    if (_insurancePlan != null) {
      map['insurance_plan'] = _insurancePlan?.map((v) => v.toJson()).toList();
    }
    if (_rides != null) {
      map['rides'] = _rides?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2025-05-20"
/// time : "10:00 AM"
/// ride_id : "RIDE001"
/// pickup : "Main Street"
/// drop : "Park Avenue"
/// status : "Completed"

Rides ridesFromJson(String str) => Rides.fromJson(json.decode(str));
String ridesToJson(Rides data) => json.encode(data.toJson());
class Rides {
  Rides({
      String? date, 
      String? time, 
      String? rideId, 
      String? pickup, 
      String? drop, 
      String? status,}){
    _date = date;
    _time = time;
    _rideId = rideId;
    _pickup = pickup;
    _drop = drop;
    _status = status;
}

  Rides.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
    _rideId = json['ride_id'];
    _pickup = json['pickup'];
    _drop = json['drop'];
    _status = json['status'];
  }
  String? _date;
  String? _time;
  String? _rideId;
  String? _pickup;
  String? _drop;
  String? _status;
Rides copyWith({  String? date,
  String? time,
  String? rideId,
  String? pickup,
  String? drop,
  String? status,
}) => Rides(  date: date ?? _date,
  time: time ?? _time,
  rideId: rideId ?? _rideId,
  pickup: pickup ?? _pickup,
  drop: drop ?? _drop,
  status: status ?? _status,
);
  String? get date => _date;
  String? get time => _time;
  String? get rideId => _rideId;
  String? get pickup => _pickup;
  String? get drop => _drop;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['time'] = _time;
    map['ride_id'] = _rideId;
    map['pickup'] = _pickup;
    map['drop'] = _drop;
    map['status'] = _status;
    return map;
  }

}

/// duration : " $15 / 6 Months"
/// rides : "3 Free Rides"
/// per_day : "$50 per ride Covered"

InsurancePlan insurancePlanFromJson(String str) => InsurancePlan.fromJson(json.decode(str));
String insurancePlanToJson(InsurancePlan data) => json.encode(data.toJson());
class InsurancePlan {
  InsurancePlan({
      String? duration, 
      String? rides, 
      String? perDay,}){
    _duration = duration;
    _rides = rides;
    _perDay = perDay;
}

  InsurancePlan.fromJson(dynamic json) {
    _duration = json['duration'];
    _rides = json['rides'];
    _perDay = json['per_day'];
  }
  String? _duration;
  String? _rides;
  String? _perDay;
InsurancePlan copyWith({  String? duration,
  String? rides,
  String? perDay,
}) => InsurancePlan(  duration: duration ?? _duration,
  rides: rides ?? _rides,
  perDay: perDay ?? _perDay,
);
  String? get duration => _duration;
  String? get rides => _rides;
  String? get perDay => _perDay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = _duration;
    map['rides'] = _rides;
    map['per_day'] = _perDay;
    return map;
  }

}