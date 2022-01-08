// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, dead_code, unused_label, empty_statements

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/pages/Login.dart';
import 'package:food_app/providers/checkout_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/providers/wish_lit_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
      ],
      child: MaterialApp(
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return HomeScreen(); // after login when app open show this page
              }
              return SignIn(); // show screen after logout
            }),
      ),
    );
  }
}
