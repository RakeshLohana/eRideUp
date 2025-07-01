import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/utils/app_utility.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/constants/assets.dart';
import '../../core/widgets/custom_elevated.dart';
import '../dashboard_screen.dart';

class InsuranceScreen extends StatefulWidget {
  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }



  Future<void> _loadUserData() async {
    final provider = Provider.of<CustomProvider>(context, listen: false);
    Customer? customer=   await SharedPreferenceService.getUserDetails();
    await provider.getDetailsUser(customer?.email??"", context);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomProvider>(
      builder: (context, value, child) =>
       Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [

                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.lightOrange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(670),
                            bottomRight: Radius.circular(800)
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 140,
                        width: 220,
                        decoration: BoxDecoration(

                          color: AppColor.appPrimaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(800),
                            // bottomRight: Radius.circular(850)
                          ),

                        ),
                      ),
                    ),

                    Positioned(
                      top: 16,
                      left: 16,
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: AppColor.black),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ),

                  ],
                ),


                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(
                    MyAssets.carInsurance,
                    height: 150,
                  ),
                ),

                Gap(10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Insurance Plan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: value.detailsUserModel?.customer?.insurancePlan?.length ?? 0,
                          itemBuilder: (context, index) {
                            InsurancePlan insurancePlan =
                                value.detailsUserModel?.customer?.insurancePlan?[index] ??
                                    InsurancePlan();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoRow(text: insurancePlan.duration ?? ""),
                                  InfoRow(text: insurancePlan.rides ?? ""),
                                  InfoRow(text: insurancePlan.perDay ?? ""),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Gap(12),
                SizedBox(
                  width: 160,
                  child: CustomElevatedButton(



                    text: 'Call Support',
                    textSize: 16,
                    onPressed: () {
                      AppUtility.launchUrlFun(AppUtility.getPhoneCallLaunchUrl(phoneNumber: value.detailsUserModel?.customer?.contactNumber??"22"));
                    },
                  ),
                ),

              ],
            ),
          ),
          if (value.isDetailsUserLoading)
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
    );
  }
}


class InfoRow extends StatelessWidget {
  final String text;

  const InfoRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(text, style: TextStyle(fontSize: 16,),textAlign: TextAlign.start,),
          Icon(Icons.check_circle, color: AppColor.lightOrange),
        ],
      ),
    );
  }
}
