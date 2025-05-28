import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/providers/auth_provider.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../core/utils/route_utils.dart';
import '../core/widgets/custom_elevated.dart';

class OTPScreen extends StatelessWidget {
   OTPScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.orangeColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) =>
         SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
                const SizedBox(height: 60),
                const CustomText(
                  text: 'Verification Code',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                const CustomText(
                  text:
                  'We have sent the verification code to your email address',
                  fontSize: 16,

                ),
                const SizedBox(height: 32),
                Center(
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      authProvider.setOtpPin(pin);
                      debugPrint('OTP entered: $pin');
                    },
                  ),
                ),
                const SizedBox(height: 50),
              authProvider.isVerifyOtpLoading?Center(child: CircularProgressIndicator(),):  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: CustomElevatedButton(


                    text: 'Continue',
                    textSize: 22,
                    backgroundColor: AppColor.appPrimaryColor,
                    onPressed: () {
                        authProvider.verifyOtp(authProvider.otpPin,authProvider.emailOrPhone,context);

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
