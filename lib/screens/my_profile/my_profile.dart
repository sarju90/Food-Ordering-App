// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, override_on_non_overriding_member, prefer_const_literals_to_create_immutables, annotate_overrides, unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/usermodal.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/drawer_side.dart';

class MyProfile extends StatefulWidget {
  late UserProvider userProvider;
  MyProfile({required this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget listTile({required IconData icon, required String title}) {
    return Column(children: [
      Divider(
        height: 1,
      ),
      ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      )
    ]);
  }

  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentData;
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      drawer: DrawerSide(
        userProvider: widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80,
                color: primaryColor,
              ),
              Container(
                height: 635,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.userName,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    userData.userEmail,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                    ),
                                    backgroundColor: scaffoldBackgroundColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(icon: Icons.shop_outlined, title: "My Orders"),
                    listTile(
                        icon: Icons.location_on_outlined,
                        title: "My Delivery Address"),
                    listTile(
                        icon: Icons.person_outline, title: "Refer A Friends"),
                    listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Terms & Conditions"),
                    listTile(
                        icon: Icons.policy_outlined, title: "Privacy Policy"),
                    listTile(icon: Icons.add_chart, title: "About"),
                    listTile(
                        icon: Icons.exit_to_app_outlined, title: "Log Out"),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userData.userImage ??
                        "https://s3.envato.com/files/328957910/vegi_thumb.png",
                  ),
                  radius: 45,
                  backgroundColor: scaffoldBackgroundColor),
            ),
          )
        ],
      ),
    );
  }
}
