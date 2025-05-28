import 'dart:convert';
/// status : true
/// message : "Customer deleted successfully"

GeneralApiResponse generalApiResponseFromJson(String str) => GeneralApiResponse.fromJson(json.decode(str));
String generalApiResponseToJson(GeneralApiResponse data) => json.encode(data.toJson());
class GeneralApiResponse {
  GeneralApiResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  GeneralApiResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
GeneralApiResponse copyWith({  bool? status,
  String? message,
}) => GeneralApiResponse(  status: status ?? _status,
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