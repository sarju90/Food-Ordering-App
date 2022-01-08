import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';

import 'package:food_app/providers/checkout_provider.dart';

import 'package:food_app/screens/home/chechout/add_deliveryaddress/add_delivery_address.dart';
import 'package:food_app/screens/home/chechout/delivery_details/single_deliveryItem.dart';
import 'package:food_app/screens/home/chechout/payment_summary/payment_summart.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Delivery Details",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressDataList.isEmpty
              ? Text("Add new Address")
              : Text("Payment Summary"),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressDataList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDeliverAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummary(
                        deliverAddressList: value,
                      ),
                    ),
                  );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressDataList.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider.getDeliveryAddressDataList
                      .map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address:
                          "aera, ${e.aera}, street, ${e.street}, society ${e.scoiety}, pincode ${e.pincode}",
                      title: "${e.firstName} ${e.lastName}",
                      number: e.mobileNo,
                      addressType: e.addressType == "AddressTypes.Home"
                          ? "Home"
                          : e.addressType == "AddressTypes.Other"
                              ? "Other"
                              : "Work",
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
