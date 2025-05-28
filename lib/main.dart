import 'package:e_ride_up/views/Drawer%20Screens/profile_screen.dart';
import 'package:e_ride_up/views/get_started_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_ride_up/providers/auth_provider.dart'; // make sure this import path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
            // Add more providers here if needed
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'eRideup',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:  GetStartedScreen(),
          ),
        );
      },
    );
  }
}
