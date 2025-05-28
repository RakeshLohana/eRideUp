import 'dart:convert';
/// status : true
/// message : "Customer updated successfully"

UpdateCustomerModel updateCustomerModelFromJson(String str) => UpdateCustomerModel.fromJson(json.decode(str));
String updateCustomerModelToJson(UpdateCustomerModel data) => json.encode(data.toJson());
class UpdateCustomerModel {
  UpdateCustomerModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  UpdateCustomerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
UpdateCustomerModel copyWith({  bool? status,
  String? message,
}) => UpdateCustomerModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}