// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, deprecated_member_use, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/wish_list_.dart/wish_list.dart';

class DrawerSide extends StatefulWidget {
  late UserProvider userProvider;
  DrawerSide({required this.userProvider});
  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({
    String? title,
    IconData? icon,
    onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 32,
        color: Colors.black,
      ),
      title: Text(
        title!,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentData;
    return Drawer(
      child: Container(
        width: 100,
        color: Color(0xffd1ad17),
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          userData.userImage ??
                              "https://s3.envato.com/files/328957910/vegi_thumb.png",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData.userName),
                        Text(
                          userData.userEmail,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            listTile(
                icon: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                }),
            listTile(
                icon: Icons.shop_outlined,
                title: "Review Cart",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ));
                }),
            listTile(
                icon: Icons.person_outline,
                title: "My Profile",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyProfile(userProvider: widget.userProvider),
                  ));
                }),
            listTile(icon: Icons.notifications_outlined, title: "Notification"),
            listTile(
              icon: Icons.star_outline,
              title: "Rating & Review",
            ),
            listTile(
                icon: Icons.favorite_outline,
                title: "Wishlist",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WishLsit(),
                  ));
                }),
            listTile(icon: Icons.copy_outlined, title: "Raise a Complaint"),
            listTile(icon: Icons.format_quote_outlined, title: "FAQs"),
            listTile(
                icon: Icons.logout_outlined,
                title: "Logout",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SignIn()),
                      (route) => false);
                }),
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Support",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        " Call us",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "+91 9016161800",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          " Mail us",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "dharsandiyasarju@gmail.com",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
