import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/core/widgets/ride_button.dart';
import 'package:e_ride_up/core/widgets/ride_history_card.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AllRidesScreen extends StatefulWidget {
  const AllRidesScreen({super.key});

  @override
  State<AllRidesScreen> createState() => _AllRidesScreenState();
}

class _AllRidesScreenState extends State<AllRidesScreen> {





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
                    return RideButton(title:"Ride ${index+1}" ,status:  ride?.status??"",
                        icon:  ride?.status==AppUtility.rideStatusOngoing ?Icons.location_on_sharp: Icons.phone,
                        iconColor: ride?.status==AppUtility.rideStatusOngoing ?Colors.red:  Colors.grey
                    );

                  },)

                ),
              ),
              const SizedBox(height: 24),
              RideHistoryCard(authProvider: authProvider,),
            ],
          ),
        ),
      ),
    );
  }
}



