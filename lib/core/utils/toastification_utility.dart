import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Enum to define toast message types
enum ToastType { success, error, info, warning }

class ToastUtil {
  /// Show a toast message based on the type
  static void showToast({
    required BuildContext context,
    required String message,
    required ToastType type,
    String? title,
  }) {
    // Determine title and ToastificationType based on the type
    String toastTitle = title ?? _getDefaultTitle(type);
    ToastificationType toastType = _getToastificationType(type);

    toastification.show(
      autoCloseDuration:  Duration(seconds: 3),
      showProgressBar: true,
      pauseOnHover: true,
      dragToClose: true,
      context: context,
      title: Text(toastTitle),
      description: Text(message),
      type: toastType,
    );
  }

  /// Helper method to get default title for each toast type
  static String _getDefaultTitle(ToastType type) {
    switch (type) {
      case ToastType.success:
        return "Success";
      case ToastType.error:
        return "Error";
      case ToastType.info:
        return "Info";
      case ToastType.warning:
        return "Warning";
    }
  }

  /// Helper method to map ToastType to ToastificationType
  static ToastificationType _getToastificationType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return ToastificationType.success;
      case ToastType.error:
        return ToastificationType.error;
      case ToastType.info:
        return ToastificationType.info;
      case ToastType.warning:
        return ToastificationType.warning;
    }
  }
}
