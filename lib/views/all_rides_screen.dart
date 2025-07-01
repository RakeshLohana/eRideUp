import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/utils/toastification_utility.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/core/widgets/ride_button.dart';
import 'package:e_ride_up/core/widgets/ride_history_card.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:e_ride_up/views/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';



class AllRidesScreen extends StatefulWidget {
  const AllRidesScreen({super.key});

  @override
  State<AllRidesScreen> createState() => _AllRidesScreenState();
}

class _AllRidesScreenState extends State<AllRidesScreen> {

  bool check=false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        leading:  Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("All Rides", style: TextStyle(color: Colors.black)),

      ),
      body: Consumer<CustomProvider>(
        builder: (context, authProvider, child) =>
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children:    List.generate(authProvider.detailsUserModel?.customer?.rides?.length??0,(index) {
                    Rides? ride=authProvider.detailsUserModel?.customer?.rides?[index];
                    return RideButton(
                      onTap: () async {




                        AppUtility.showModal(context: context, child:

                        BookByWidget(
                          onBookBySupport: () async {
                            printLog('ddddd');

                            if(ride?.status==AppUtility.rideStatusNotRequested){
                              printLog("dadadada");
                              final provider = Provider.of<CustomProvider>(context, listen: false);
                              Customer? customer=   await SharedPreferenceService.getUserDetails();
                              Position? position=  await   AppUtility.getCurrentLocation();
                              if(position!=null){
                                printLog('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

                                await provider.createRide(customer?.email??"", position.latitude.toString()??"", position.longitude.toString()??"", context);

                                AppUtility.launchUrlFun(AppUtility.getPhoneCallLaunchUrl(phoneNumber: authProvider.detailsUserModel?.customer?.contactNumber??"222"));
                              }


                            }else{
                              ToastUtil.showToast(context: context, message: "Ride ${index+1} is already booked", type: ToastType.info);
                            }
                            Navigator.pop(context);
                          },
                          onBookByYourself: () {
                            printLog("sssss");
                            Navigator.pop(context);

                          },
                        )

                        );


                      },
                        title:"Ride ${index+1}" ,status:  ride?.status??"",
                        icon:  ride?.status==AppUtility.rideStatusOngoing ?Icons.location_on_sharp: Icons.phone,
                        iconColor: ride?.status==AppUtility.rideStatusOngoing ?Colors.red:  Colors.grey
                    );

                  },)

                ),
              ),
              const SizedBox(height: 24),
              if(authProvider.createRideModel?.status==true)
              Align(
                alignment: Alignment.center,
                child: CustomElevatedButton(
                  width: 200,
                  text: "Track Ride",
                  onPressed: () {
                    RouteUtils.push(context, RideTrackingScreen(rideId: authProvider.createRideModel?.rideId.toString()??"",));
                  },
                  backgroundColor: AppColor.orangeColor,

                ),
              ),
              RideHistoryCard(authProvider: authProvider,),
            ],
          ),
        ),
      ),
    );
  }
}

class BookByWidget extends StatelessWidget {
  final void Function()?  onBookByYourself;
  final void Function()?  onBookBySupport;
  const BookByWidget({
    super.key,
    required this.onBookBySupport,
    required  this.onBookByYourself,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Choose Booking Option",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Book by Yourself"),
            onTap:  onBookByYourself
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text("Book by Support"),
            onTap: onBookBySupport,
          ),
        ],
      ),
    );
  }
}



