import 'dart:convert';
/// status : true
/// message : "Details fetched successfully"
/// customer : {"id":"71","name":"rakeshlohana","email":"rakeshlohana15@gmail.com","phone":"300000000","address":"Karachi Sindh","city":"Karachi","state":"Sindh","country":"Pakistan","postal_code":"DSF","date_of_birth":"2025-07-08","gender":"male","profile_image":"https://innsurance.flash-speed.online/","status":"0","isDeleted":"0","createdBy":"22","createdDtm":"2025-07-07 21:16:32","updatedBy":null,"updatedDtm":"2025-07-07 21:18:09","total_rides":null,"used_rides":null,"remaining_rides":null,"contact_number":"1111111111111","insurance_plan":[{"duration":"$15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"}],"rides":[{"id":"15","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null},{"id":"16","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null},{"id":"17","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null}]}

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

/// id : "71"
/// name : "rakeshlohana"
/// email : "rakeshlohana15@gmail.com"
/// phone : "300000000"
/// address : "Karachi Sindh"
/// city : "Karachi"
/// state : "Sindh"
/// country : "Pakistan"
/// postal_code : "DSF"
/// date_of_birth : "2025-07-08"
/// gender : "male"
/// profile_image : "https://innsurance.flash-speed.online/"
/// status : "0"
/// isDeleted : "0"
/// createdBy : "22"
/// createdDtm : "2025-07-07 21:16:32"
/// updatedBy : null
/// updatedDtm : "2025-07-07 21:18:09"
/// total_rides : null
/// used_rides : null
/// remaining_rides : null
/// contact_number : "1111111111111"
/// insurance_plan : [{"duration":"$15 / 6 Months","rides":"3 Free Rides","per_day":"$50 per ride Covered"}]
/// rides : [{"id":"15","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null},{"id":"16","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null},{"id":"17","user_id":"71","pickup":"","drop":"","status":"Not Requested","created_at":"2025-07-07 21:16:32","updated_at":"2025-07-07 21:16:32","pickup_lat":null,"pickup_lng":null,"otp":null,"arriving_time":null,"amount_cover":null,"amount_you_pay":null,"drop_lat":null,"drop_lng":null}]

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
      dynamic updatedBy, 
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
  dynamic _updatedBy;
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
  dynamic updatedBy,
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
  dynamic get updatedBy => _updatedBy;
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

/// id : "15"
/// user_id : "71"
/// pickup : ""
/// drop : ""
/// status : "Not Requested"
/// created_at : "2025-07-07 21:16:32"
/// updated_at : "2025-07-07 21:16:32"
/// pickup_lat : null
/// pickup_lng : null
/// otp : null
/// arriving_time : null
/// amount_cover : null
/// amount_you_pay : null
/// drop_lat : null
/// drop_lng : null

Rides ridesFromJson(String str) => Rides.fromJson(json.decode(str));
String ridesToJson(Rides data) => json.encode(data.toJson());
class Rides {
  Rides({
      String? id, 
      String? userId, 
      String? pickup, 
      String? drop, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic pickupLat, 
      dynamic pickupLng, 
      dynamic otp, 
      dynamic arrivingTime, 
      dynamic amountCover, 
      dynamic amountYouPay, 
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

  Rides.fromJson(dynamic json) {
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
  dynamic _pickupLat;
  dynamic _pickupLng;
  dynamic _otp;
  dynamic _arrivingTime;
  dynamic _amountCover;
  dynamic _amountYouPay;
  dynamic _dropLat;
  dynamic _dropLng;
Rides copyWith({  String? id,
  String? userId,
  String? pickup,
  String? drop,
  String? status,
  String? createdAt,
  String? updatedAt,
  dynamic pickupLat,
  dynamic pickupLng,
  dynamic otp,
  dynamic arrivingTime,
  dynamic amountCover,
  dynamic amountYouPay,
  dynamic dropLat,
  dynamic dropLng,
}) => Rides(  id: id ?? _id,
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
  dynamic get pickupLat => _pickupLat;
  dynamic get pickupLng => _pickupLng;
  dynamic get otp => _otp;
  dynamic get arrivingTime => _arrivingTime;
  dynamic get amountCover => _amountCover;
  dynamic get amountYouPay => _amountYouPay;
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

/// duration : "$15 / 6 Months"
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