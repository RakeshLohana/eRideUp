import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/core/widgets/custom_text_field.dart';
import 'package:e_ride_up/core/widgets/signup_pompt.dart';
import 'package:e_ride_up/core/widgets/textfield_icon.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:e_ride_up/views/otp_screen.dart';
import 'package:e_ride_up/discard/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appPrimaryColor,
      body: Consumer<CustomProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(MyAssets.brandLogo, height: 100),
                        const SizedBox(height: 40),

                        CustomTextField(
                          onTap: () => emailController.clear(),
                          controller: phoneController,
                          label: "Phone Number",
                          suffixIcon: IconTextField(iconData: Icons.phone),
                          keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final phoneReg = RegExp(r'^\+\d{10,15}$');
                                if (!phoneReg.hasMatch(value)) {
                                  return 'Enter a valid phone number with country code';
                                }
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(child: Divider(color: AppColor.white, endIndent: 10)),
                            CustomText(text: "or", color: AppColor.white, fontSize: 22),
                            Expanded(child: Divider(color: AppColor.white, indent: 10)),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// Email Field
                        CustomTextField(
                          onTap: () => phoneController.clear(),
                          controller: emailController,
                          label: "Email",
                          suffixIcon: IconTextField(iconData: Icons.mail),
                          keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailReg.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: authProvider.isLoginLoading
                              ? Center(child: CircularProgressIndicator(color: AppColor.orangeColor))
                              : CustomElevatedButton(
                            text: 'Continue',
                            textSize: 22,
                            backgroundColor: AppColor.orangeColor,
                            onPressed: () async {
                              if ((emailController.text.trim().isEmpty && phoneController.text.trim().isEmpty)) {
                                ToastUtil.showToast(
                                  context: context,
                                  message: 'Please enter either phone number or email.',
                                  type: ToastType.error,
                                );
                                return;
                              }

                              if (!_formKey.currentState!.validate()) return;

                              try {
                                await authProvider.login(emailController.text, phoneController.text, context);

                                if (authProvider.loginData?.status == true) {
                                  emailController.clear();
                                  phoneController.clear();
                                  RouteUtils.pushReplacement(context, OTPScreen());
                                } else {
                                  ToastUtil.showToast(
                                    context: context,
                                    message: '${authProvider.loginData?.message}',
                                    type: ToastType.error,
                                  );
                                }
                              } catch (e) {
                                printLog(e.toString());
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 50),
                        // SignUpPrompt(onTap: () {
                        //   emailController.clear();
                        //   phoneController.clear();
                        //   RouteUtils.push(context, SignUpScreen());
                        // }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
