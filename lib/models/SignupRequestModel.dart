import 'dart:convert';
/// name : "aftab hussain"
/// email : "gixob93869@pngzero.com"
/// phone : "23232123"
/// address : "234"
/// city : "234"
/// state : "4324"
/// country : "324"
/// postal_code : "234"
/// date_of_birth : "2025-09-11"
/// gender : "male"
/// is_google : "true"

SignupRequestModel signupRequestModelFromJson(String str) => SignupRequestModel.fromJson(json.decode(str));
String signupRequestModelToJson(SignupRequestModel data) => json.encode(data.toJson());
class SignupRequestModel {
  SignupRequestModel({
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
      String? isGoogle,}){
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
    _isGoogle = isGoogle;
}

  SignupRequestModel.fromJson(dynamic json) {
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
    _isGoogle = json['is_google'];
  }
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
  String? _isGoogle;
SignupRequestModel copyWith({  String? name,
  String? email,
  String? phone,
  String? address,
  String? city,
  String? state,
  String? country,
  String? postalCode,
  String? dateOfBirth,
  String? gender,
  String? isGoogle,
}) => SignupRequestModel(  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  postalCode: postalCode ?? _postalCode,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  isGoogle: isGoogle ?? _isGoogle,
);
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
  String? get isGoogle => _isGoogle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (_name != null && _name!.isNotEmpty) map['name'] = _name;
    if (_email != null && _email!.isNotEmpty) map['email'] = _email;
    if (_phone != null && _phone!.isNotEmpty) map['phone'] = _phone;
    if (_address != null && _address!.isNotEmpty) map['address'] = _address;
    if (_city != null && _city!.isNotEmpty) map['city'] = _city;
    if (_state != null && _state!.isNotEmpty) map['state'] = _state;
    if (_country != null && _country!.isNotEmpty) map['country'] = _country;
    if (_postalCode != null && _postalCode!.isNotEmpty) map['postal_code'] = _postalCode;
    if (_dateOfBirth != null && _dateOfBirth!.isNotEmpty) map['date_of_birth'] = _dateOfBirth;
    if (_gender != null && _gender!.isNotEmpty) map['gender'] = _gender;
    if (_isGoogle != null && _isGoogle!.isNotEmpty) map['is_google'] = _isGoogle;

    return map;
  }

}