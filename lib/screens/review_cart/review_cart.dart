// ignore_for_file: void_checks, dead_code

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/home/chechout/delivery_details/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late ReviewCartProvider reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you want to delete cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Aount"),
        subtitle: Text(
          "Rs ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text("Submit"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              setState(() {
                reviewCartProvider.getReviewCartDataList.isEmpty
                    ? Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReviewCart()))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeliveryDetails()));
              });

              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "No Cart Data Found");
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DeliveryDetails()));
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Review Cart",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingalItem(
                      isBool: true,
                      wishList: false,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      ProductUnit: data.cartUnit,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
