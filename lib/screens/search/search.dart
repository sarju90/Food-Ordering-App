// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';

import 'package:food_app/widgets/single_item.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Items",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color(0xffc2c2c2),
                filled: true,
                hintText: "Search for items in the store",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 29,
          ),
          Column(
            children: _searchItem.map((data) {
              return SingalItem(
                isBool: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                onDelete: () {},
                wishList: false,
                productQuantity: 2,
                ProductUnit: data.productUnit,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
