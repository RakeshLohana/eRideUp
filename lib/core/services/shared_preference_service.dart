import 'dart:convert';

import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/models/LoginOtpResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceService {
  static const _userKey = 'userData';

  static Future<void> saveUserDetails(LoginOtpResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = loginOtpResponseToJson(response);
    await prefs.setString(_userKey, jsonString);
  }

  static Future<Customer?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      final loginResponse = loginOtpResponseFromJson(jsonString);
      return loginResponse.customer;
    }
    return null;
  }

  static Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
