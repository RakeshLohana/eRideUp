
import 'dart:developer';

import 'package:flutter/foundation.dart';


const kLOG_TAG = "[eRideUp]";
const kLOG_ENABLE = kDebugMode;

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    log("$kLOG_TAG ${data.toString()}");
  }
}