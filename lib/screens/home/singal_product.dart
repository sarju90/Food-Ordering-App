// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, camel_case_types, prefer_typing_uninitialized_variables, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/productunit.dart';

class singalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final String productId;
  final ProductModel productUnit;
  final onTap;

  singalProduct({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.onTap,
    required this.productId,
    required this.productUnit,
  });

  @override
  State<singalProduct> createState() => _singalProductState();
}

class _singalProductState extends State<singalProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 245,
            width: 165,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 140,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(widget.productImage),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${widget.productPrice} Rs ${unitData == null ? firstValue : unitData}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: ProductUnit(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: widget
                                                  .productUnit.productUnit
                                                  .map<Widget>((data) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            unitData = data;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          data,
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                              /*children: <Widget>[
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
                                              ],*/
                                            );
                                          });
                                    },
                                    title: unitData == null
                                        ? firstValue
                                        : unitData,
                                  ),
                                  /*child: InkWell(
                                    onTap: () {
                                      
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "50 Gram",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                size: 20,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Count(
                                productName: widget.productName,
                                productImage: widget.productImage,
                                productPrice: widget.productPrice,
                                productId: widget.productId,
                                productUnit:
                                    unitData == null ? firstValue : unitData,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
