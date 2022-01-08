// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/screens/home/chechout/google_map/google.dart';
import 'package:food_app/widgets/ctext_field.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    late CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Add Delivery Address",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CostomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
              keyboardType: TextInputType.number,
            ),
            CostomTextField(
                labText: "Alternate Mobile No",
                controller: checkoutProvider.alternateMobileNo,
                keyboardType: TextInputType.number),
            CostomTextField(
              labText: "Scoiety",
              controller: checkoutProvider.scoiety,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Street",
              controller: checkoutProvider.street,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Landmark",
              controller: checkoutProvider.landmark,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "City",
              controller: checkoutProvider.city,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Aera",
              controller: checkoutProvider.aera,
              keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Pincode",
              controller: checkoutProvider.pincode,
              keyboardType: TextInputType.number,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CostomGoogleMap(),
                ));
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null
                        ? Text("Set Loaction")
                        : Text(" Your Location is Set Done!!!"),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.work,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.devices_other,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
