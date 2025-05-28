import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/models/LoginOtpResponse.dart';
import 'package:e_ride_up/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, size: 28),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Gap(10),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
            const Gap(10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Privacy Policies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const Gap(10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.privacyPolicyColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4), // subtle downward shadow
                  ),
                ],
              ),
              child: const Text(
                "We value your privacy. This app collects limited personal data, such as your name, email, and usage information, only to provide and improve our services.\n"
                    "We do not share your information with third parties except as required by law or for essential services (like analytics or authentication).\n"
                    "You can delete your account and personal data anytime by using the \"Delete Account\" option.\n"
                    "By using this app, you agree to this privacy policy. If you have any questions, please contact us at eRideup@info.com",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),

            const Gap(24),

            Consumer<AuthProvider>(
              builder: (context, provider, _) {
                return ElevatedButton.icon(
                  onPressed: provider.isDeleteProfileLoading
                      ? null
                      : () async {
                    Customer? customer = await SharedPreferenceService.getUserDetails();
                    if (customer?.id?.isNotEmpty??false) {
                      await provider.deleteCustomerAccount(customer?.id??"", context);
                    } else {
                      ToastUtil.showToast(
                        context: context,
                        message: "Customer ID not found.",
                        type: ToastType.error,
                      );
                    }
                  },
                  icon: provider.isDeleteProfileLoading
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                      : Icon(Icons.delete, color: Colors.red),
                  label: Text(
                    provider.isDeleteProfileLoading ? "Deleting..." : "Delete Account",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            )




          ],
        ),
      ),
    );
  }
}
