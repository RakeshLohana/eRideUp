import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:url_launcher/url_launcher.dart';

class AppUtility {


  static Future<void> showModal({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 24.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        );
      },
    );
  }





  static String getWhatsappLaunchUrl({required String whatsappNumber}) {
    return "https://wa.me/${whatsappNumber}";
  }

  static String getPhoneCallLaunchUrl({required String phoneNumber}) {
    return "tel:${phoneNumber}";
  }

  static String getMailLaunchUrl({required String mail}) {
    return "mailto:${mail}";
  }

  static String getGoogleMapUrl({required String address}) {
    final query = Uri.encodeComponent(address);

    return "https://www.google.com/maps/search/?api=1&query=$query";
  }

  static Future<void> launchUrlWebsite(String url, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ToastUtil.showToast(
          context: context,
          message: "Could not open ${url}",
          type: ToastType.error);
    }
  }

  static Future<void> launchUrlFun(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(mode: LaunchMode.externalApplication, Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  static Map<String, double> calculatePieChartData({
    required String totalRides,
    required String usedRides,
    required String remainingRides,
  }) {
    final total = double.tryParse(totalRides) ?? 0;
    final used = double.tryParse(usedRides) ?? 0;
    final remaining = double.tryParse(remainingRides) ?? 0;

    if (total > 0) {
      return {
        "Used": (used / total) * 100,
        "Remaining": (remaining / total) * 100,
      };
    } else {
      return {
        "Used": 0,
        "Remaining": 0,
      };
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> googleSigIn() async {
    try {
      final googleClient = GoogleSignIn(scopes: ['email', 'profile']);
      await googleClient.signOut();
      GoogleSignInAccount? googleAccount = await googleClient.signIn();
      printLog("This google account ---->" + googleAccount.toString());
      return googleAccount;
    } catch (error) {
      printLog(error);
      printLog('Google sign-in failed');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  static String rideStatusOngoing = "Ongoing";
  static String rideStatusCompleted = "Completed";
  static String rideStatusNotRequested = "Not Requested";

  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return null;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return null;
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
