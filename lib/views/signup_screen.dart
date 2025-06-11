import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/models/SignupRequestModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:e_ride_up/views/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../core/widgets/country_number_field.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneController=TextEditingController();

  String _fullPhoneNumber = "";

  bool isUsingEmail = false;
  final emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CustomProvider>(
        builder: (context, value, child) =>
         SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isUsingEmail?   Text(
                    'Enter your email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ):  Text(
                    'Enter your mobile number',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  isUsingEmail
                      ? TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      focusedBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: const BorderSide(
                          color: AppColor.orangeColor,
                          width: 1.0,
                        ),
                      ) ,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: const BorderSide(
                          color: AppColor.textInputLabel,
                          width: 1.0,
                        ),
                      ),

                    ),
                  )
                      : TextInputPhone(
                    controller: phoneController,
                    initialCountryCode: "IN",
                    currentLocale: "en",
                    hint: "Enter phone",
                    floatingLabel: "Phone Number",
                    inputAction: TextInputAction.done,
                    onChanged: (PhoneNumber number) {
                      setState(() {
                        _fullPhoneNumber = number.completeNumber;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: value.isSignUpLoading
                        ? Center(child: CircularProgressIndicator(color: AppColor.orangeColor)):
                    CustomElevatedButton(
                      textSize: 20,
                      backgroundColor: AppColor.orangeColor,
                      onPressed: () {
                        if (isUsingEmail) {
                          final email = emailController.text.trim();
                          if (email.isEmpty || !email.contains('@')) {
                            ToastUtil.showToast(context: context, message: "Please enter a valid email", type: ToastType.warning);
                            return;
                          }
                          SignupRequestModel request = SignupRequestModel(email: email);
                          value.signUp(request, context);
                        } else {
                          if (_fullPhoneNumber.isEmpty) {
                            ToastUtil.showToast(context: context, message: "Please enter your phone number", type: ToastType.warning);

                            return;
                          }
                          SignupRequestModel request = SignupRequestModel(phone: _fullPhoneNumber);
                          value.signUp(request, context);
                        }
                      },

                      text: 'Continue',

                    ),),
                   SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("or"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildOutlinedButton(
                    icon: SvgPicture.asset(MyAssets.googleIcon),
                    label: 'Continue with Google',
                      onPressed: () async {
                        try {
                          await GoogleSignIn().signOut();
                          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                          if (googleUser == null) {
                            ToastUtil.showToast(context: context, message: "Google Sign-In Cancelled", type: ToastType.error);
                            printLog("Google Sign-In cancelled");
                            return;
                          }

                          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken,
                          );

                          final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                          final User? user = userCredential.user;

                          if (user != null) {
                            printLog("Firebase user: ${user.displayName}, ${user.email}");

                            SignupRequestModel signupRequest = SignupRequestModel(
                              name: user.displayName,
                              email: user.email,
                              phone: user.phoneNumber,
                              isGoogle: "true",
                            );
                            value.signUp(signupRequest, context);
                          }
                        } catch (e) {
                          ToastUtil.showToast(context: context, message: "Google Sign-In failed", type: ToastType.error);
                          printLog("Sign-in error: $e");
                        }
                      }
                  ),

                  const SizedBox(height: 12),
                  _buildOutlinedButton(
                    icon: Icon(
                      isUsingEmail ? Icons.phone : Icons.email_outlined,
                      color: Colors.orange,
                      size: 25,
                    ),
                    label: isUsingEmail ? 'Continue with Phone' : 'Continue with Email',
                    onPressed: () {
                      setState(() {
                        isUsingEmail = !isUsingEmail;
                      });
                    },
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("or"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.search),
                  //   label: const Text('Find my account'),
                  // ),
                  // const SizedBox(height: 20),
                  const CustomText(
                    maxLines: 5,
                    fontSize: 10,
                    color: AppColor.textPrimary,
                    text: "By proceeding, you consent to get calls, WhatsApp or SMS/RCS messages, including by automated means, from eRideUp and its affliliates to the number provided.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
