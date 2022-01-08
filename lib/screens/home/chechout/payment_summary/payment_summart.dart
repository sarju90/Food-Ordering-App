// ignore_for_file: unused_local_variable

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/home/chechout/add_deliveryaddress/add_delivery_address.dart';
import 'package:food_app/screens/home/chechout/delivery_details/single_deliveryItem.dart';
import 'package:food_app/screens/home/chechout/payment_summary/mygoogle_pay.dart';
import 'package:food_app/screens/home/chechout/payment_summary/order_item.dart';
import 'package:food_app/screens/home/order_placed.dart';
import 'package:provider/provider.dart';

import 'order_item.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  PaymentSummary({required this.deliverAddressList});
  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
  Work,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 30;
    double discountValue = 0;
    double total = reviewCartProvider.getTotalPrice();
    double shippingCharge = 40;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Payment Summary",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "${total + 40 ?? totalPrice} Rs",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.OnlinePayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyGooglePay(
                          total: total,
                        ),
                      ),
                    )
                  : Container();

              myType == AddressTypes.Home
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlaceOrder(),
                      ),
                    )
                  : Container();
            },
            child: Text(
              "Pleace Order",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                    title:
                        "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                    address:
                        "area, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society, ${widget.deliverAddressList.scoiety}, pincode, ${widget.deliverAddressList.pincode},",
                    number: widget.deliverAddressList.mobileNo,
                    addressType: widget.deliverAddressList.addressType ==
                            "AddressTypes.Other"
                        ? "Other"
                        : widget.deliverAddressList.addressType ==
                                "AddressTypes.Home"
                            ? "Home"
                            : "Work"),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "${totalPrice + 40} Rs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "40 Rs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Coupan Discount",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "${discountValue} Rs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Payment Options"),
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
                    Icons.work,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
