// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unused_element, avoid_print, empty_catches, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app/pages/Login.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProvider;

  _googleSignUp() async {
    try {
      final _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user,
        userEmail: user!.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );

      return user;
    } catch (e) {}
  }

  @override
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background.jpeg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    'Vegi',
                    style:
                        TextStyle(fontSize: 50, color: Colors.white, shadows: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.green.shade900,
                        offset: Offset(3, 3),
                      )
                    ]),
                  ),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Apple,
                        text: "Sign in with Apple",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.GoogleDark,
                        text: 'Sign in with Google',
                        onPressed: () {
                          _googleSignUp().then(
                            (value) => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('Sign in Phone Number'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('By Signing in you are agreeing to our',
                          style: TextStyle(color: Colors.grey[800])),
                      Text('Terms and Privacy Policy',
                          style: TextStyle(color: Colors.grey[800])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
