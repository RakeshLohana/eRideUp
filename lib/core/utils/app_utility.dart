import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


class AppUtility{



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

 static  Map<String, double> calculatePieChartData({
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


  static String rideStatusOngoing="Ongoing";
  static String rideStatusCompleted="Completed";
  static String rideStatusNotRequested="Not Requested";

}