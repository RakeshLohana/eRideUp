import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';




class RideTrackingScreen extends StatefulWidget {
  final String rideId;

  const RideTrackingScreen({super.key,required this.rideId});
  @override
  _RideTrackingScreenState createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  late GoogleMapController _mapController;

   static LatLng _pickupLocation = LatLng(32.6099, -85.4808); // Auburn
  static  LatLng _dropoffLocation = LatLng(34.0522, -118.2437); // LA

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('pickup'),
      position: _pickupLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('dropoff'),
      position: _dropoffLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };

  final Set<Polyline> _polylines = {
    Polyline(
      polylineId: PolylineId('route'),
      color: Colors.red,
      width: 4,
      points: [_pickupLocation, _dropoffLocation],
    ),
  };


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRideData();
  }


  Future<void> _loadRideData() async {
    final provider = Provider.of<CustomProvider>(context, listen: false);
    Customer? customer=   await SharedPreferenceService.getUserDetails();
    await provider.getRide(customer?.email??"",widget.rideId, context);
    if(provider.getRideDetails?.status==true){
      _pickupLocation=LatLng(double.parse(provider.getRideDetails?.ride?.pickupLat??"0.0"), double.parse(provider.getRideDetails?.ride?.pickupLat??"0.0"));

    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
         drawer: CustomDrawer(),
        // backgroundColor: const Color(0xFF0D1A47),
        body: Consumer<CustomProvider>(
          builder: (context, value, child) =>
           Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _pickupLocation,
                  zoom: 10 ,
                ),
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
              Positioned(
                // top: 40,
                // left: 20,
                // right: 20,
                child: _buildTopBar(value),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _buildBottomPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(CustomProvider provider) {
    return Container(
      height: 170,
      padding: EdgeInsets.all(10),
      color: AppColor.appPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:  [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              SizedBox(width: 10),
              Text("Track your Ride", style: TextStyle(color: Colors.white, fontSize: 18)),
              Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.appPrimaryColor,
              border: Border.all(color: Colors.white30),
            ),
            child:  Row(
              children: [
                Icon(Icons.circle, size: 10, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "En route To\n${provider.getRideDetails?.ride?.drop??""}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 270,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1A47),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Row(
                    children: [
                      Text("Cab", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                    ],
                  ),
                  SizedBox(height: 4),
                  Text("Will be arrived in 15min", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Text("Est. Fare: \$62", style: TextStyle(color: Colors.white)),
                  Text("\$50 covered by eRideUp.", style: TextStyle(color: Colors.greenAccent)),
                  Text("You pay: \$12.", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("OTP: 3002", style: TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold)),

                    ],
                  ),
                ],
              ),
              Gap(5),
              SvgPicture.asset(MyAssets.cab,width: 70,)
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(0.4)
          ),
          child: const Text(
            "Reminder: Only 3 breakdown rides allowed every 6 months.",
            style: TextStyle(color: Colors.red, fontSize: 10),
          ),
        )
      ],
    );
  }
}
