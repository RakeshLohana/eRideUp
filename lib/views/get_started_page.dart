import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:e_ride_up/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../core/constants/assets.dart';
import '../core/utils/route_utils.dart';
import '../core/widgets/custom_text.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(

              maxLines: 2,
              text: TextSpan(

                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
                children:  [
                  TextSpan(
                    text: 'eRide',
                    style: TextStyle(
                      fontSize: 45,
                        color: AppColor.appPrimaryColor),
                  ),
                  TextSpan(

                    text: 'Up',
                    style: TextStyle(
                        fontSize: 45,

                        color: AppColor.orangeColor),
                  ),
                ],
              ),
            ),
            Gap(10),


            Center(
              child: Image.asset(
                MyAssets.getStarted,
              ),
            ),

            Gap(80),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                   CustomText(
                     maxLines: 2,
                    text: 'Get started with eRideUp',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),

                   Gap( 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomElevatedButton(
                      icon: Icons.arrow_forward_ios,


                      text: 'Continue',
                      textSize: 22,
                      onPressed: () async {
                        final user = await SharedPreferenceService.getUserDetails();
                        if (user != null) {
                          RouteUtils.pushReplacement(context, DashboardScreen());
                        } else {
                          RouteUtils.push(context, LoginScreen());
                        }
                      },

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
