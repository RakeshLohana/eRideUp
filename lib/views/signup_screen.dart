import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/widgets/country_number_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countryCode = "+91";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your mobile number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                TextInputPhone(
                  suffixIcon: Icon(Icons.key,color: AppColor.orangeColor ,),

                  hint: "Mobile number",

                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    textSize: 20,
                    backgroundColor: AppColor.orangeColor,
                    onPressed: () {
                      RouteUtils.push(context, DashboardScreen());

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
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                _buildOutlinedButton(
                  icon: Icon(Icons.email_outlined, color: Colors.orange,size: 25,),
                  label: 'Continue with Email',
                  onPressed: () {},
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
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  label: const Text('Find my account'),
                ),
                const SizedBox(height: 20),
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
