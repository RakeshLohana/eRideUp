import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:flutter/material.dart';

class RideButton extends StatefulWidget {
  final String title;
  final Color iconColor;
  final String status;
  final IconData icon;
  const RideButton({super.key, required this.title, required this.iconColor, required this.icon, required this.status});

  @override
  State<RideButton> createState() => _RideButtonState();
}


class _RideButtonState extends State<RideButton> {

  @override
  Widget build(BuildContext context) {
    printLog("Current status: '${widget.status}'");

    Color textColor;

    switch (widget.status.trim().toLowerCase()) {
      case "completed":
        textColor = Colors.grey;
        break;
      case "ongoing":
        textColor = Colors.green;
        break;
      case "not requested":
        textColor = Colors.orange;
        break;
      default:
        textColor = Colors.black;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),

        Text(widget.status, style: TextStyle(color: textColor, fontStyle: FontStyle.italic)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColor.appPrimaryColor, Colors.indigo]),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: const Icon(Icons.directions_car, color: Colors.white),
            title: Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: Icon(widget.icon, color: widget.iconColor),
          ),
        ),
      ],
    );
  }

}
