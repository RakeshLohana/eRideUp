import 'dart:math';

import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/models/CreateRideModel.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/models/GeneralApiResponse.dart';
import 'package:e_ride_up/models/GetRideDetails.dart';
import 'package:e_ride_up/models/LoginOtpResponse.dart';
import 'package:e_ride_up/models/UpdateCustomerModel.dart';
import 'package:e_ride_up/models/WalletSummaryModel.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:e_ride_up/views/login_screen.dart';
import 'package:e_ride_up/views/otp_screen.dart';
import 'package:flutter/material.dart';
import '../core/services/api_client.dart';
import '../core/services/api_service.dart';
import '../core/utils/toastification_utility.dart';
import '../models/LoginResponse.dart';
import '../models/SignupRequestModel.dart';

class CustomProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();


  bool _isSignUpLoading = false;
  bool get isSignUpLoading => _isSignUpLoading;


  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  bool _isWalletSummaryLoading = false;
  bool get isWalletSummaryLoading => _isWalletSummaryLoading;


  bool _isCreateRideLoading = false;
  bool get isCreateRideLoading => _isCreateRideLoading;

  bool _isGetRideLoading = false;
  bool get isGetRideLoading => _isGetRideLoading;


  bool _isVerifyOtpLoading = false;
  bool get isVerifyOtpLoading => _isVerifyOtpLoading;


  LoginResponse? _loginData;
  LoginResponse? get loginData=>_loginData;


  WalletSummaryModel? _walletSummaryModel;
  WalletSummaryModel? get walletSummaryModel=>_walletSummaryModel;

  CreateRideModel? _createRideModel;
  CreateRideModel? get createRideModel=>_createRideModel;

  GetRideDetails? _getRideDetails;
  GetRideDetails? get getRideDetails=>_getRideDetails;

  UpdateCustomerModel? _updateCustomerModel;
  UpdateCustomerModel? get updateCustomerModel=>_updateCustomerModel;


  GeneralApiResponse? _generalApiResponse;
  GeneralApiResponse? get generalApiResponse=>_generalApiResponse;

  GeneralApiResponse? _signUpResponse;
  GeneralApiResponse? get signUpResponse=>_signUpResponse;


  DetailsUserModel? _detailsUserModel;
  DetailsUserModel? get detailsUserModel=>_detailsUserModel;

  String _otpPin = "";
  String get otpPin =>_otpPin;

  int _bottomIndex = 1;
  int get bottomIndex =>_bottomIndex;

  String _emailOrPhone = "";
  String get emailOrPhone => _emailOrPhone;


  LoginOtpResponse? _otpResponse;
  LoginOtpResponse? get otpResponse=>_otpResponse;


  bool _isUpdateProfileLoading = false;
  bool get isUpdateProfileLoading => _isUpdateProfileLoading;



  bool _isDeleteProfileLoading = false;
  bool get isDeleteProfileLoading => _isDeleteProfileLoading;

  bool _isDetailsUserLoading = false;
  bool get isDetailsUserLoading => _isDetailsUserLoading;





   Map<String, double> _pieChartData = {};
  Map<String, double> get pieChartData => _pieChartData;

  void setOtpPin(String pin){
    _otpPin=pin;
    notifyListeners();
  }


  void setBottomBarIndex(int index){
    _bottomIndex=index;
    notifyListeners();
  }

  void setEmailOrPhone(String emailOrPhone){
    _emailOrPhone=emailOrPhone;
    notifyListeners();
  }



  Future<void> getWalletSummary(String emailOrPhone, BuildContext context) async {
    _isWalletSummaryLoading = true;
    notifyListeners();

    try {
      _walletSummaryModel = await _apiService.getWalletSummary(emailOrPhone);
      if(_walletSummaryModel?.status==true){
        printLog(_walletSummaryModel?.toJson());
      }
    } catch (e) {
      printLog(e.toString());
      ToastUtil.showToast(context: context,message: ' login failed: ${e}',type: ToastType.error);


    } finally {
      _isWalletSummaryLoading = false;
      notifyListeners();
    }
  }


  Future<void> getRide(String email,String rideId, BuildContext context) async {
    _isGetRideLoading = true;
    notifyListeners();

    try {
      _getRideDetails = await _apiService.getRide(email,rideId);
      if(_getRideDetails?.status==true){
        printLog(_getRideDetails?.toJson());
      }
    } catch (e) {
      printLog(e.toString());
      ToastUtil.showToast(context: context,message: 'Getting Ride details failed',type: ToastType.error);


    } finally {
      _isGetRideLoading = false;
      notifyListeners();
    }
  }




  Future<void> createRide(String email,String lat,String lng  , BuildContext context) async {
    _isCreateRideLoading = true;
    notifyListeners();

    try {
      _createRideModel = await _apiService.createRide(email,lat,lng);
      if(_createRideModel?.status==true){
        printLog(_createRideModel?.toJson());
      }
    } catch (e) {
      printLog(e.toString());
      ToastUtil.showToast(context: context,message: 'Ride create failed',type: ToastType.error);


    } finally {
      _isCreateRideLoading = false;
      notifyListeners();
    }
  }


  Future<void> login(String email,String phone, BuildContext context) async {
    _isLoginLoading = true;
    notifyListeners();

    try {
      _loginData = await _apiService.login(email,phone);
    } catch (e) {
      printLog(e.toString());

      ToastUtil.showToast(context: context,message: ' login failed: ${e}',type: ToastType.error);


    } finally {
      _isLoginLoading = false;
      notifyListeners();
    }
  }


  Future<void> signUp(SignupRequestModel signUpRequestModel, BuildContext context) async {
    _isSignUpLoading = true;
    notifyListeners();

    try {
      _signUpResponse = await _apiService.signUp(signUpRequestModel);
      if(_signUpResponse?.status==true){
        ToastUtil.showToast(context: context,message: _signUpResponse?.message??"",type: ToastType.success);
         if(bool.parse(signUpRequestModel.isGoogle??"false")==true){
           await SharedPreferenceService.saveUserDetails(LoginOtpResponse(
             customer: Customer(
               phone: signUpRequestModel.phone,
               email: signUpRequestModel.email,

             )
           ));

           RouteUtils.pushReplacement(context, DashboardScreen());

         }else{
           RouteUtils.pushReplacement(context, OTPScreen());

         }

      }
      notifyListeners();
    } catch (e) {
      ToastUtil.showToast(context: context,message: 'SignUp Failed',type: ToastType.error);
    } finally {
      _isSignUpLoading = false;
      notifyListeners();
    }
  }



  Future<void> verifyOtp(String otp, String emailOrPhone,BuildContext context) async {
    _isVerifyOtpLoading = true;
    notifyListeners();

    try {
      _otpResponse = await _apiService.verifyOtp(otp, emailOrPhone);

      if (_otpResponse != null && _otpResponse?.status==true) {
        await SharedPreferenceService.saveUserDetails(_otpResponse??LoginOtpResponse());
        RouteUtils.pushReplacement(context, DashboardScreen());
        ToastUtil.showToast(context: context, message: "Otp verified successfully", type: ToastType.success);

      }

    } catch (e) {
      ToastUtil.showToast(context: context, message: e.toString(), type: ToastType.error);
      printLog("error in verifying otp:===>" + e.toString());
    } finally {
      _isVerifyOtpLoading = false;
      notifyListeners();
    }
  }


  Future<void> updateCustomerDetails(Customer customer, BuildContext context) async {
    _isUpdateProfileLoading = true;
    notifyListeners();

    try {
      _updateCustomerModel = await _apiService.updateCustomer(customer);

      if (_updateCustomerModel?.message != null && _updateCustomerModel?.status == true) {
        await SharedPreferenceService.saveUserDetails(LoginOtpResponse(message: _updateCustomerModel?.message, status: _updateCustomerModel?.status,customer: customer));
          await getDetailsUser(customer.email??"", context);
        ToastUtil.showToast(
          context: context,
          message: _updateCustomerModel?.message??"",
          type: ToastType.success,
        );
      } else {
        ToastUtil.showToast(
          context: context,
          message: _updateCustomerModel?.message ?? "Failed to update profile.",
          type: ToastType.warning,
        );
      }
    } catch (e) {
      ToastUtil.showToast(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
      printLog("Error updating customer: $e");
    } finally {
      _isUpdateProfileLoading = false;
      notifyListeners();
    }
  }



  Future<void> deleteCustomerAccount(String customerId, BuildContext context) async {
    _isDeleteProfileLoading = true;
    notifyListeners();

    try {
      _generalApiResponse = await _apiService.deleteCustomer(customerId);

      if (_generalApiResponse?.status == true) {
        ToastUtil.showToast(
          context: context,
          message: _generalApiResponse?.message ?? "Account deleted successfully.",
          type: ToastType.success,
        );

        await SharedPreferenceService.clearUserDetails();

        RouteUtils.pushAndRemoveUntil(context,LoginScreen());
      } else {
        ToastUtil.showToast(
          context: context,
          message: _generalApiResponse?.message ?? "Failed to delete account.",
          type: ToastType.warning,
        );
      }
    } catch (e) {
      ToastUtil.showToast(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
      printLog("Error deleting customer: $e");
    } finally {
      _isDeleteProfileLoading = false;
      notifyListeners();
    }
  }



  Future<void> getDetailsUser(String emailOrPhone, BuildContext context) async {
    _isDetailsUserLoading = true;
    notifyListeners();

    try {
        _detailsUserModel = await _apiService.getDetailsUser(emailOrPhone);




      if (_detailsUserModel?.status == true) {


        _pieChartData =AppUtility. calculatePieChartData(
          totalRides: _detailsUserModel?.customer?.totalRides ?? "0",
          usedRides: _detailsUserModel?.customer?.usedRides ?? "0",
          remainingRides: _detailsUserModel?.customer?.remainingRides ?? "0",
        );





      } else {
        ToastUtil.showToast(
          context: context,
          message: _detailsUserModel?.message ?? "Failed to fetch UserDetails.",
          type: ToastType.warning,
        );
      }
    } catch (e) {
      ToastUtil.showToast(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
      printLog("Error getting user details: $e");
    } finally {
      _isDetailsUserLoading = false;
      notifyListeners();
    }
  }





}
