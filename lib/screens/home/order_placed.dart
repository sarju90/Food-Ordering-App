import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/placed_order_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Order Placed",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: Text("Back To HomeScreen"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(
            'assets/download12.jpg',
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
