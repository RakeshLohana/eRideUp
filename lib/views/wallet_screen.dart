import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}




class _WalletScreenState extends State<WalletScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWalletData();

  }



  Future<void> _loadWalletData() async {
    final provider = Provider.of<CustomProvider>(context, listen: false);
    Customer? customer=   await SharedPreferenceService.getUserDetails();
    await provider.getWalletSummary(customer?.email??"", context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black  ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('Wallet', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Consumer<CustomProvider>(
        builder: (context, value, child) =>
         SingleChildScrollView(
          child: Column(
            children: [
              // Card
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF142C7A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VISA', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.credit_card, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(value.walletSummaryModel?.card?.cardNumber??"",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('EXPIRE\n ${value.walletSummaryModel?.card?.expiry??""}', style: TextStyle(color: Colors.white)),
                        Text('CVV\n${value.walletSummaryModel?.card?.cvc??""}', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              // Balance Info
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Available balance', style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Text('\$${value.walletSummaryModel?.card?.availableBalance??""}', style: TextStyle(color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.arrow_downward, color: Colors.green, size: 30),
                            Text('\$${value.walletSummaryModel?.card?.income??""}', style: TextStyle(color: Colors.green, fontSize: 16)),
                            Text('Income', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.red, size: 30),
                            Text('\$${value.walletSummaryModel?.card?.spending??""}', style: TextStyle(color: Colors.red, fontSize: 16)),
                            Text('Spending', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Transactions
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TRANSACTIONS', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('18 June', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 16),

                    Column(
                      children: List.generate(value.walletSummaryModel?.transactions?.length??0, (index) =>
                          transactionItem(value.walletSummaryModel?.transactions?[index].transactionName??'',
                              value.walletSummaryModel?.transactions?[index].date??'' ,
                              '+ \$${value.walletSummaryModel?.transactions?[index].amount??''}'),),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   backgroundColor: Color(0xFF142C7A),
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: ''),
      //   ],
      // ),
    );
  }

  Widget transactionItem(String title, String time, String amount) {
    return ListTile(
      leading: Icon(Icons.directions_car, color: Colors.grey[700]),
      title: Text(title),
      subtitle: Text(time),
      trailing: Text(amount, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
    );
  }
}
