// import 'dart:async';
//
// import 'package:e_ride_up/core/constants/app_colors.dart';
// import 'package:e_ride_up/core/constants/assets.dart';
// import 'package:e_ride_up/core/constants/general.dart';
// import 'package:e_ride_up/core/services/shared_preference_service.dart';
// import 'package:e_ride_up/core/utils/route_utils.dart';
// import 'package:e_ride_up/core/widgets/custom_drawer.dart';
// import 'package:e_ride_up/core/widgets/custom_elevated.dart';
// import 'package:e_ride_up/models/DetailsUserModel.dart';
// import 'package:e_ride_up/models/GetRideDetails.dart';
// import 'package:e_ride_up/providers/custom_provider.dart';
// import 'package:e_ride_up/views/dashboard_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
//
//
//
// class RideTrackingScreen extends StatefulWidget {
//   final String rideId;
//
//   const RideTrackingScreen({super.key,required this.rideId});
//   @override
//   _RideTrackingScreenState createState() => _RideTrackingScreenState();
// }
//
// class _RideTrackingScreenState extends State<RideTrackingScreen> {
//   late GoogleMapController _mapController;
//
//    static LatLng _pickupLocation = LatLng(32.6099, -85.4808); // Auburn
//   static  LatLng _dropoffLocation = LatLng(34.0522, -118.2437); // LA
//
//
//   Timer? _rideDataTimer;
//
//   final Set<Marker> _markers = {
//     Marker(
//       markerId: MarkerId('pickup'),
//       position: _pickupLocation,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//     ),
//     Marker(
//       markerId: MarkerId('dropoff'),
//       position: _dropoffLocation,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//     ),
//   };
//
//   final Set<Polyline> _polylines = {
//     Polyline(
//       polylineId: PolylineId('route'),
//       color: Colors.red,
//       width: 4,
//       points: [_pickupLocation, _dropoffLocation],
//     ),
//   };
//
//
//   @override
//   void dispose() {
//     _rideDataTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadRideData();
//     _rideDataTimer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
//       _loadRideData();
//       printLog("Timer --->"+timer.toString());
//     });
//   }
//
//
//   Future<void> _loadRideData() async {
//     final provider = Provider.of<CustomProvider>(context, listen: false);
//     Customer? customer = await SharedPreferenceService.getUserDetails();
//
//     await provider.getRide(customer?.email ?? "", widget.rideId, context);
//
//     if (provider.getRideDetails?.status == true) {
//       LatLng newPickup = LatLng(
//         double.parse(provider.getRideDetails?.ride?.pickupLat ?? "0.0"),
//         double.parse(provider.getRideDetails?.ride?.pickupLng ?? "0.0"),
//       );
//
//       LatLng newDropoff = LatLng(
//         double.parse(provider.getRideDetails?.ride?.dropLat ?? "0.0"),
//         double.parse(provider.getRideDetails?.ride?.dropLng ?? "0.0"),
//       );
//
//       if (mounted) {
//         setState(() {
//           _pickupLocation = newPickup;
//           _dropoffLocation = newDropoff;
//
//           _markers.clear();
//           _markers.addAll({
//             Marker(
//               markerId: MarkerId('pickup'),
//               position: _pickupLocation,
//               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//             ),
//             Marker(
//               markerId: MarkerId('dropoff'),
//               position: _dropoffLocation,
//               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//             ),
//           });
//
//           _polylines.clear();
//           _polylines.add(
//             Polyline(
//               polylineId: PolylineId('route'),
//               color: Colors.red,
//               width: 4,
//               points: [_pickupLocation, _dropoffLocation],
//             ),
//           );
//         });
//
//         printLog("Pickup LatLong: -------> $_pickupLocation");
//         printLog("DropOff LatLong: -------> $_dropoffLocation");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//
//       child: Scaffold(
//          drawer: CustomDrawer(),
//         // backgroundColor: const Color(0xFF0D1A47),
//         body: Consumer<CustomProvider>(
//           builder: (context, value, child) =>
//            Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: _pickupLocation,
//                   zoom: 10 ,
//                 ),
//                 markers: _markers,
//                 polylines: _polylines,
//                 onMapCreated: (controller) {
//                   _mapController = controller;
//                 },
//               ),
//               Positioned(
//                 // top: 40,
//                 // left: 20,
//                 // right: 20,
//                 child: _buildTopBar(value),
//               ),
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: _buildBottomPanel(value),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopBar(CustomProvider provider) {
//     return Container(
//       height: 170,
//       padding: EdgeInsets.all(10),
//       color: AppColor.appPrimaryColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children:  [
//               Builder(
//                 builder: (context) => IconButton(
//                   icon: Icon(Icons.menu, color: Colors.white),
//                   onPressed: () => Scaffold.of(context).openDrawer(),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Text("Track your Ride", style: TextStyle(color: Colors.white, fontSize: 18)),
//               Spacer(),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: AppColor.appPrimaryColor,
//               border: Border.all(color: Colors.white30),
//             ),
//             child:  Row(
//               children: [
//                 Icon(Icons.circle, size: 10, color: Colors.white),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     "En route To\n${provider.getRideDetails?.ride?.drop??""}",
//                     style: TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomPanel(CustomProvider customProvider) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 270,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF0D1A47),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:  [
//                   Text("Cab", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4),
//                   Text("Will be arrived in ${customProvider.getRideDetails?.ride?.arrivingTime??"0"}min", style: TextStyle(color: Colors.white70)),
//                   SizedBox(height: 10),
//                   Text("Est. Fare: \$${double.parse(customProvider.getRideDetails?.ride?.amountCover??"0.0")+double.parse(customProvider.getRideDetails?.ride?.amountYouPay??"0.0")}", style: TextStyle(color: Colors.white)),
//                   Text("\$${customProvider.getRideDetails?.ride?.amountCover??"0"} covered by eRideUp.", style: TextStyle(color: Colors.greenAccent)),
//                   Text("You pay: \$${customProvider.getRideDetails?.ride?.amountYouPay??"0"}.", style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text("OTP: ${customProvider.getRideDetails?.ride?.otp}", style: TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold)),
//
//                     ],
//                   ),
//                 ],
//               ),
//               Gap(5),
//
//               Column(
//                 children: [
//                   CustomElevatedButton(
//                     width: 80,
//                     height: 30,
//                     borderRadius: 5,
//                     text: "Start Ride",
//
//                     onPressed: () {
//                       customProvider.clearRideDetails();
//                       RouteUtils.pushReplacement(context, DashboardScreen());
//                     },
//                     backgroundColor: AppColor.orangeColor,
//
//                   ),
//
//                   SvgPicture.asset(MyAssets.cab,width: 70,),
//                 ],
//               )
//             ],
//           ),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
//           decoration: BoxDecoration(
//             color: AppColor.grey.withOpacity(0.4)
//           ),
//           child: const Text(
//             "Reminder: Only 3 breakdown rides allowed every 6 months.",
//             style: TextStyle(color: Colors.red, fontSize: 10),
//           ),
//         )
//       ],
//     );
//   }
// }






import 'dart:async';
import 'dart:math';

import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/core/utils/route_utils.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/core/widgets/custom_elevated.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:e_ride_up/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RideTrackingScreen extends StatefulWidget {
  final String rideId;

  const RideTrackingScreen({super.key, required this.rideId});

  @override
  _RideTrackingScreenState createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  late GoogleMapController _mapController;

  static LatLng _pickupLocation = LatLng(24.8607, 67.0011);
  static LatLng _dropoffLocation = LatLng(24.9263, 67.0220);


  Timer? _rideDataTimer;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  String _estimatedTime = "";


  @override
  void initState() {
    super.initState();
    _loadRideData();
    _rideDataTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      _loadRideData();
    });
  }
  bool _isRideStarted = false;

  @override
  void dispose() {
    _rideDataTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadRideData() async {
    final provider = Provider.of<CustomProvider>(context, listen: false);
    Customer? customer = await SharedPreferenceService.getUserDetails();

    await provider.getRide(customer?.email ?? "", widget.rideId, context);

    if (provider.getRideDetails?.status == true) {
      LatLng newPickup = LatLng(
        double.parse(provider.getRideDetails?.ride?.pickupLat ?? "32.6099"),
        double.parse(provider.getRideDetails?.ride?.pickupLng ?? "-85.4808"),
      );

      LatLng newDropoff = LatLng(
        double.parse(provider.getRideDetails?.ride?.dropLat ?? "34.0522"),
        double.parse(provider.getRideDetails?.ride?.dropLng ?? "-118.2437"),
      );

      if (mounted) {
        setState(() {
          _pickupLocation = newPickup;
          _dropoffLocation = newDropoff;

          _markers.clear();
          _markers.addAll({
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
          });
        });

        await _getPolylinePoints();

        // Optional: Auto-adjust camera
        LatLngBounds bounds = LatLngBounds(
          southwest: LatLng(
            min(_pickupLocation.latitude, _dropoffLocation.latitude),
            min(_pickupLocation.longitude, _dropoffLocation.longitude),
          ),
          northeast: LatLng(
            max(_pickupLocation.latitude, _dropoffLocation.latitude),
            max(_pickupLocation.longitude, _dropoffLocation.longitude),
          ),
        );
        _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      }
    }
  }

  Future<void> _getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];


    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyD1Mgji2oCIXn7jPCHnImwZuDAdCfe7SMI",

     request:  PolylineRequest(

        optimizeWaypoints: true,
        origin:       PointLatLng(_pickupLocation.latitude, _pickupLocation.longitude),

       destination:      PointLatLng(_dropoffLocation.latitude, _dropoffLocation.longitude),
       mode: TravelMode.driving,
    ));

    final durationInSeconds = await AppUtility.getTravelDurationInMinutes(
      originLat: _pickupLocation.latitude,
      originLng: _pickupLocation.longitude,
      destLat:_dropoffLocation.latitude,
      destLng: _dropoffLocation.longitude,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      if (mounted) {
        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            color: Colors.red,
            width: 4,
            points: polylineCoordinates,
          ));

          _estimatedTime =durationInSeconds.toString();

        });
      }
    } else {
      print("Polyline error: ${result.errorMessage}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Consumer<CustomProvider>(
          builder: (context, value, child) => Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _pickupLocation,
                  zoom: 6,
                ),
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
              Positioned(child: _buildTopBar(value)),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _buildBottomPanel(value),
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
            children: [
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
            child: Row(
              children: [
                Icon(Icons.circle, size: 10, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "En route To\n${provider.getRideDetails?.ride?.drop ?? ""}",
                    maxLines: 2,
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

  Widget _buildBottomPanel(CustomProvider customProvider) {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cab",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    _isRideStarted==false?  Text(
                      "Will arrive in ${customProvider.getRideDetails?.ride?.arrivingTime ?? "0"} min",
                      style: TextStyle(color: Colors.white70),
                    ): Text(
                      "Estimated time ${_estimatedTime} min",
                      maxLines: 2,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Est. Fare: \$${(double.tryParse(customProvider.getRideDetails?.ride?.amountCover.toString() ?? '') ?? 0.0) + (double.tryParse(customProvider.getRideDetails?.ride?.amountYouPay.toString() ?? '') ?? 0.0)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "\$${customProvider.getRideDetails?.ride?.amountCover?.toString() ?? "0"} covered by eRideUp.",
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    Text(
                      "You pay: \$${customProvider.getRideDetails?.ride?.amountYouPay?.toString() ?? "0"}.",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "OTP: ${_isRideStarted ? (customProvider.getRideDetails?.ride?.otp ?? "-") : "****"}",
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Gap(5),
              Column(
                children: [
                  CustomElevatedButton(
                    width: 80,
                    height: 30,
                    borderRadius: 5,
                    text: "Start Ride",
                    onPressed: () {
                      setState(() {
                        _isRideStarted = true;
                      });
                      customProvider.clearRideDetails();
                      // RouteUtils.pushReplacement(context, DashboardScreen());
                    },
                    backgroundColor: AppColor.orangeColor,
                  ),
                  SvgPicture.asset(MyAssets.cab, width: 70),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(0.4),
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



