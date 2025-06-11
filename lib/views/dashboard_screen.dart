import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Drawer Screens/insurance_screen.dart';
import 'Drawer Screens/profile_screen.dart';
import 'Drawer Screens/ride_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 1;

  final List<Widget> _screens = [
    ProfileScreen(),
    InsuranceScreen(),
    RideScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Consumer<CustomProvider>(
      builder: (context, value, child) =>
       Scaffold(
        backgroundColor: Colors.white,
        drawer:CustomDrawer(),
        body:  _screens[value.bottomIndex],

         bottomNavigationBar: BottomNavigationBar(
           onTap: (index) {
             value.setBottomBarIndex(index);
             _currentIndex = index;
           },
           backgroundColor: AppColor.appPrimaryColor,
           selectedItemColor: AppColor.orangeColor,
           unselectedItemColor: AppColor.white,
           currentIndex: value.bottomIndex,
           items: const [
             BottomNavigationBarItem(
               icon: Icon(Icons.person, size: 30),
               label: '',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.home, size: 30),
               label: '',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.directions_car, size: 30),
               label: '',
             ),
           ],
         ),
      ),
    );
  }
}




