import 'dart:convert';

import 'package:e_ride_up/models/DetailsUserModel.dart';
/// status : true
/// message : "Login successful"
/// customer : {"id":"7","name":"aftab khubani","email":"rakeshlohana15@gmail.com","phone":"+923463960892","address":"Chori gali khokharpar","city":"Jabal pur","state":"New Delhi","country":"Pakistan","postal_code":"9200","date_of_birth":"2025-05-30","gender":"male","profile_image":"https://innsurance.flash-speed.online/assets/images/avatar","status":"1","isDeleted":"0","createdBy":"15","createdDtm":"2025-05-13 15:33:46","updatedBy":null,"updatedDtm":"2025-05-24 09:14:23"}

LoginOtpResponse loginOtpResponseFromJson(String str) => LoginOtpResponse.fromJson(json.decode(str));
String loginOtpResponseToJson(LoginOtpResponse data) => json.encode(data.toJson());
class LoginOtpResponse {
  LoginOtpResponse({
      bool? status, 
      String? message, 
      Customer? customer,}){
    _status = status;
    _message = message;
    _customer = customer;
}

  LoginOtpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  bool? _status;
  String? _message;
  Customer? _customer;
LoginOtpResponse copyWith({  bool? status,
  String? message,
  Customer? customer,
}) => LoginOtpResponse(  status: status ?? _status,
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

/// id : "7"
/// name : "aftab khubani"
/// email : "rakeshlohana15@gmail.com"
/// phone : "+923463960892"
/// address : "Chori gali khokharpar"
/// city : "Jabal pur"
/// state : "New Delhi"
/// country : "Pakistan"
/// postal_code : "9200"
/// date_of_birth : "2025-05-30"
/// gender : "male"
/// profile_image : "https://innsurance.flash-speed.online/assets/images/avatar"
/// status : "1"
/// isDeleted : "0"
/// createdBy : "15"
/// createdDtm : "2025-05-13 15:33:46"
/// updatedBy : null
/// updatedDtm : "2025-05-24 09:14:23"

// Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
// String customerToJson(Customer data) => json.encode(data.toJson());
// class Customer {
//   Customer({
//       String? id,
//       String? name,
//       String? email,
//       String? phone,
//       String? address,
//       String? city,
//       String? state,
//       String? country,
//       String? postalCode,
//       String? dateOfBirth,
//       String? gender,
//       String? profileImage,
//       String? status,
//       String? isDeleted,
//       String? createdBy,
//       String? createdDtm,
//       dynamic updatedBy,
//       String? updatedDtm,}){
//     _id = id;
//     _name = name;
//     _email = email;
//     _phone = phone;
//     _address = address;
//     _city = city;
//     _state = state;
//     _country = country;
//     _postalCode = postalCode;
//     _dateOfBirth = dateOfBirth;
//     _gender = gender;
//     _profileImage = profileImage;
//     _status = status;
//     _isDeleted = isDeleted;
//     _createdBy = createdBy;
//     _createdDtm = createdDtm;
//     _updatedBy = updatedBy;
//     _updatedDtm = updatedDtm;
// }
//
//   Customer.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _email = json['email'];
//     _phone = json['phone'];
//     _address = json['address'];
//     _city = json['city'];
//     _state = json['state'];
//     _country = json['country'];
//     _postalCode = json['postal_code'];
//     _dateOfBirth = json['date_of_birth'];
//     _gender = json['gender'];
//     _profileImage = json['profile_image'];
//     _status = json['status'];
//     _isDeleted = json['isDeleted'];
//     _createdBy = json['createdBy'];
//     _createdDtm = json['createdDtm'];
//     _updatedBy = json['updatedBy'];
//     _updatedDtm = json['updatedDtm'];
//   }
//   String? _id;
//   String? _name;
//   String? _email;
//   String? _phone;
//   String? _address;
//   String? _city;
//   String? _state;
//   String? _country;
//   String? _postalCode;
//   String? _dateOfBirth;
//   String? _gender;
//   String? _profileImage;
//   String? _status;
//   String? _isDeleted;
//   String? _createdBy;
//   String? _createdDtm;
//   dynamic _updatedBy;
//   String? _updatedDtm;
// Customer copyWith({  String? id,
//   String? name,
//   String? email,
//   String? phone,
//   String? address,
//   String? city,
//   String? state,
//   String? country,
//   String? postalCode,
//   String? dateOfBirth,
//   String? gender,
//   String? profileImage,
//   String? status,
//   String? isDeleted,
//   String? createdBy,
//   String? createdDtm,
//   dynamic updatedBy,
//   String? updatedDtm,
// }) => Customer(  id: id ?? _id,
//   name: name ?? _name,
//   email: email ?? _email,
//   phone: phone ?? _phone,
//   address: address ?? _address,
//   city: city ?? _city,
//   state: state ?? _state,
//   country: country ?? _country,
//   postalCode: postalCode ?? _postalCode,
//   dateOfBirth: dateOfBirth ?? _dateOfBirth,
//   gender: gender ?? _gender,
//   profileImage: profileImage ?? _profileImage,
//   status: status ?? _status,
//   isDeleted: isDeleted ?? _isDeleted,
//   createdBy: createdBy ?? _createdBy,
//   createdDtm: createdDtm ?? _createdDtm,
//   updatedBy: updatedBy ?? _updatedBy,
//   updatedDtm: updatedDtm ?? _updatedDtm,
// );
//   String? get id => _id;
//   String? get name => _name;
//   String? get email => _email;
//   String? get phone => _phone;
//   String? get address => _address;
//   String? get city => _city;
//   String? get state => _state;
//   String? get country => _country;
//   String? get postalCode => _postalCode;
//   String? get dateOfBirth => _dateOfBirth;
//   String? get gender => _gender;
//   String? get profileImage => _profileImage;
//   String? get status => _status;
//   String? get isDeleted => _isDeleted;
//   String? get createdBy => _createdBy;
//   String? get createdDtm => _createdDtm;
//   dynamic get updatedBy => _updatedBy;
//   String? get updatedDtm => _updatedDtm;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['email'] = _email;
//     map['phone'] = _phone;
//     map['address'] = _address;
//     map['city'] = _city;
//     map['state'] = _state;
//     map['country'] = _country;
//     map['postal_code'] = _postalCode;
//     map['date_of_birth'] = _dateOfBirth;
//     map['gender'] = _gender;
//     map['profile_image'] = _profileImage;
//     map['status'] = _status;
//     map['isDeleted'] = _isDeleted;
//     map['createdBy'] = _createdBy;
//     map['createdDtm'] = _createdDtm;
//     map['updatedBy'] = _updatedBy;
//     map['updatedDtm'] = _updatedDtm;
//     return map;
//   }
//
// }