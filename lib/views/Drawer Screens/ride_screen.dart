import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:e_ride_up/views/all_rides_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';



class RideScreen extends StatefulWidget {
  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final Map<String, double> dataMapNew = {
    "Used": 0,
    "Remaining": 100.0,
  };

  final List<Color> colorList = [
    AppColor.orangeColor,
    AppColor.pieChartBlue,
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();

  }

  void _loadData() async {
      final provider = Provider.of<CustomProvider>(context, listen: false);
      Customer? customer = await SharedPreferenceService.getUserDetails();
      await provider.getDetailsUser(customer?.email??"", context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        toolbarHeight: 30,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ) ,
      ),
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      body: Consumer<CustomProvider>(
        builder: (context, authProvider, child) => Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap( 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(AppUtility.getGreeting(), style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 4),
                                  Text( authProvider.detailsUserModel?.customer?.name??"", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text("Plan Status: ",
                                          style: TextStyle(fontSize: 14)),
                                      authProvider.detailsUserModel?.customer?.status=="1"?    Text("Active",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green))
                                          :Text("UnActive",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          ),
                          const SizedBox(height: 20),

                            Center(
                              child: Column(
                                children: [
                                  PieChart(
                                    dataMap: authProvider.pieChartData.isEmpty?dataMapNew:authProvider.pieChartData,
                                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 24,
                                    colorList: colorList,
                                    chartValuesOptions: const ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                      showChartValues: true,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                   Text("${authProvider.detailsUserModel?.customer?.remainingRides??"0"} rides remaining",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),

                          const SizedBox(height: 20),

                          GestureDetector(
                            onTap: () {
                              RouteUtils.push(context, AllRidesScreen());
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 6),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("My Current Plan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                  Icon(Icons.arrow_forward_ios, size: 16),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          GestureDetector(
                            onTap: () {
                              AppUtility.launchUrlFun(AppUtility.getPhoneCallLaunchUrl(phoneNumber: authProvider.detailsUserModel?.customer?.contactNumber??"222"));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.only(top:36),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, blurRadius: 6),
                                    ],
                                  ),
                                  child: Column(
                                    children: [


                                      Column(

                                        children: [
                                          const SizedBox(height: 25),
                                          const Text("Renew Your Plan", style: TextStyle(fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          const Text("Your Subscription is near the expiry date,\ncontact for more information",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12)),
                                          const SizedBox(height: 8),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo[900],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: const CustomText(text: "Renew",color: AppColor.white,),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 35,
                                    backgroundImage: AssetImage(MyAssets.renewIcon),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          const SizedBox(height: 5),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (authProvider.isDetailsUserLoading)
              Container(
                color: Colors.black45,
                child:  Center(
                  child: CircularProgressIndicator(
                    color: AppColor.appPrimaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
