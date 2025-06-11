import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';

class RideHistoryCard extends StatefulWidget {
  final CustomProvider authProvider;
  const RideHistoryCard({super.key, required this.authProvider});

  @override
  State<RideHistoryCard> createState() => _RideHistoryCardState();
}


class _RideHistoryCardState extends State<RideHistoryCard> {

  List<Rides>? rides;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rides=widget.authProvider.detailsUserModel?.customer?.rides?.where((ride) =>ride.status?.toLowerCase()==AppUtility.rideStatusCompleted.toLowerCase() ,).toList();

  }
  Widget buildRideRow(String label, String? value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold)),
        Flexible(
          child: Text(
            value ?? "",
            style: TextStyle(color: color),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ride History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(

                children:List.generate(rides?.length??0, (index) {
                  Rides? ride=rides?[index];

                  return   Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.privacyPolicyColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Ride ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("${index + 1}  ", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Flexible(
                                      child: Text(
                                        ride?.date ?? '',
                                        style: const TextStyle(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                buildRideRow("Ride ID: ", ride?.rideId, Colors.teal),
                                buildRideRow("Pickup: ", ride?.pickup, Colors.blue),
                                buildRideRow("Drop: ", ride?.drop, Colors.green),
                                buildRideRow("Status: ", ride?.status, Colors.green),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                },)

          ),
        ),
      ],
    );
  }
}