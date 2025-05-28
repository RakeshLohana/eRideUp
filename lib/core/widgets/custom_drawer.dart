import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/auth_provider.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:e_ride_up/views/login_screen.dart';
import 'package:e_ride_up/views/all_rides_screen.dart';
import 'package:e_ride_up/views/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  Future<void> _loadUserData() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
      Customer? customer=   await SharedPreferenceService.getUserDetails();
      await provider.getDetailsUser(customer?.email??"", context);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) =>
          Drawer(
            width: 250,
            backgroundColor: AppColor.white,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: ClipOval(
                            child: Image.network(
                              value.detailsUserModel?.customer?.profileImage ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Icon(Icons.person, color: Colors.deepOrange, size: 50),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),



                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(value.detailsUserModel?.customer?.name??"", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(value.detailsUserModel?.customer?.email??"", style: TextStyle(fontSize: 12)),
                              Text("ID: ${value.detailsUserModel?.customer?.id??""}", style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  // Menu Items
                  DrawerItem(icon: Icons.home, text: "Home", onTap: () {
                    Navigator.pop(context);
                  }),
                  DrawerItem(icon: Icons.person, text: "My Profile", onTap: () {
                    RouteUtils.pushAndRemoveUntil(context, DashboardScreen());

                  }),
                  DrawerItem(icon: Icons.assignment, text: "My Plan", onTap: () {
                    value.setBottomBarIndex(2);
                    RouteUtils.pushAndRemoveUntil(context, DashboardScreen());

                  }),
                  DrawerItem(icon: Icons.directions_car, text: "My Rides", onTap: () {
                    Navigator.pop(context);

                    RouteUtils.push(context, AllRidesScreen());


                  }),
                  DrawerItem(icon: Icons.location_on, text: "Track My Ride", onTap: () {
                    Navigator.pop(context);

                  }),
                  DrawerItem(icon: Icons.support_agent, text: "Call Support", onTap: () {
                    Navigator.pop(context);
                    AppUtility.launchUrlFun(AppUtility.getPhoneCallLaunchUrl(phoneNumber: value.detailsUserModel?.customer?.contactNumber??"222"));

                  }),
                  DrawerItem(icon: Icons.settings, text: "Settings", onTap: () {
                    RouteUtils.pop(context);
                    RouteUtils.push(context, PrivacyPolicyScreen());

                  }),

                  const Spacer(),
                  DrawerItem(
                    icon: Icons.logout,
                    text: "Log Out",
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () async {
                      await SharedPreferenceService.clearUserDetails();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                            (route) => false,
                      );
                    },
                  ),
                  Gap(10),
                ],
              ),
            ),
          ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const DrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColor.orangeColor),
      title: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
