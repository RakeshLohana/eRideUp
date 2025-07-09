import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_ride_up/models/CreateRideModel.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/models/GeneralApiResponse.dart';
import 'package:e_ride_up/models/GetRideDetails.dart';
import 'package:e_ride_up/models/LoginOtpResponse.dart';
import 'package:e_ride_up/models/SignupRequestModel.dart';
import 'package:e_ride_up/models/UpdateCustomerModel.dart';
import 'package:e_ride_up/models/WalletSummaryModel.dart';


import '../../models/LoginResponse.dart';
import '../constants/api_urls.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _client = ApiClient();

  Future<LoginResponse> login(String email,String phone) async {
    Response response = await _client.post(
      isFormData: true,
      AppUrls.login,
      {
        'email': email,
        'phone': phone,
      },
    );
    return LoginResponse.fromJson(response.data);
  }


  Future<WalletSummaryModel> getWalletSummary(String emailOrPhone) async {
    Response response = await _client.post(
      isFormData: true,
      AppUrls.getWalletSummary,
      {
        'email_or_phone': emailOrPhone,
      },
    );
    return WalletSummaryModel.fromJson(response.data);
  }


  Future<GeneralApiResponse> signUp(SignupRequestModel signUpRequestModel) async {
    Response response = await _client.post(
      isFormData: true,
      AppUrls.signUp,
        signUpRequestModel.toJson()
    );
    return GeneralApiResponse.fromJson(response.data);
  }



  Future<LoginOtpResponse> verifyOtp(String otp,String emailOrPhone) async {
    Response response = await _client.post(
      isFormData: true,
      AppUrls.verifyLoginOtp,
      {'otp': otp,'email_or_phone':emailOrPhone},
    );
    return LoginOtpResponse.fromJson(response.data);
  }


  Future<UpdateCustomerModel> updateCustomer(Customer customer) async {
    final Map<String, dynamic> body = {
      'customerId': customer.id,
      'email': customer.email,
      'phone': customer.phone,
      'name': customer.name,
      'address': customer.address,
      'city': customer.city,
      'state': customer.state,
    };

    if (customer.profileImage != null ||customer.profileImage!="") {
     body ['image']=File(customer.profileImage??"");
    }
    Response response = await _client.post(
      isFormData: true,
      AppUrls.updateCustomer,
      body,
    );

    return UpdateCustomerModel.fromJson(response.data);
  }


  Future<GeneralApiResponse> deleteCustomer(String customerId) async {
    final String url = "${AppUrls.deleteCustomer}?customerId=$customerId";

    Response response = await _client.post(url,null);
    return GeneralApiResponse.fromJson(response.data);
  }


  Future<DetailsUserModel> getDetailsUser(String emailOrPhone) async {


    Response response = await _client.post(
      isFormData: true,
      AppUrls.detailsUser,
      {"email_or_phone":emailOrPhone},
    );

    return DetailsUserModel.fromJson(response.data);
  }



  Future<CreateRideModel> createRide(String email,String lat,String lng,String type ,String rideId) async {


    Response response = await _client.post(
      isFormData: true,
      AppUrls.createRide,
      {
        "email":email,
        "lat":lat,
        "lng":lng,
        "ride_id":rideId,
        "type":type
      },
    );

    return CreateRideModel.fromJson(response.data);
  }


  Future<GetRideDetails> getRide(String email ,String rideId) async {


    Response response = await _client.post(
      isFormData: true,
      AppUrls.getRide+"/${rideId}" ,
      {
        "email":email,

      },
    );

    return GetRideDetails.fromJson(response.data);
  }


}
