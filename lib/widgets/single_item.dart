// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/widgets/count.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/widgets/productunit.dart';
import 'package:provider/provider.dart';

class SingalItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  bool wishList = false;
  int productPrice;
  String productId;
  int productQuantity;
  Function() onDelete;
  var ProductUnit;
  SingalItem({
    required this.isBool,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQuantity,
    required this.onDelete,
    required this.wishList,
    required this.ProductUnit,
  });

  @override
  State<SingalItem> createState() => _SingalItemState();
}

class _SingalItemState extends State<SingalItem> {
  late ReviewCartProvider reviewCartProvider;

  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(widget.productImage),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Text(
                              "${widget.productPrice} Rs",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: new Text('250 Gram'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('500 Gram'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('1 Kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('2 Kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "50 Gram",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text(widget.ProductUnit)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    height: 100,
                    padding: widget.isBool == false
                        ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                        : EdgeInsets.only(left: 15, right: 15),
                    child: widget.isBool == false
                        ? Count(
                            productName: widget.productName,
                            productImage: widget.productImage,
                            productPrice: widget.productPrice,
                            productId: widget.productId,
                            productUnit: widget.ProductUnit,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: widget.onDelete,
                                  child: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.wishList == false
                                    ? Container(
                                        height: 25,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (count == 1) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "You reach minimum limit",
                                                    );
                                                  } else {
                                                    setState(() {
                                                      count--;
                                                    });
                                                    reviewCartProvider
                                                        .updateReviewCartData(
                                                      cartImage:
                                                          widget.productImage,
                                                      cartId: widget.productId,
                                                      cartName:
                                                          widget.productName,
                                                      cartPrice:
                                                          widget.productPrice,
                                                      cartQuantity: count,
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                              Text(
                                                "$count",
                                                style: TextStyle(
                                                  color: primaryColor,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (count > 5) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "You reach miximum limit",
                                                    );
                                                  } else {
                                                    setState(() {
                                                      count++;
                                                    });
                                                    reviewCartProvider
                                                        .updateReviewCartData(
                                                      cartImage:
                                                          widget.productImage,
                                                      cartId: widget.productId,
                                                      cartName:
                                                          widget.productName,
                                                      cartPrice:
                                                          widget.productPrice,
                                                      cartQuantity: count,
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }
}
