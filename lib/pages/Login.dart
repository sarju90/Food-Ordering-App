// ignore_for_file: unused_import, file_names, constant_identifier_names, prefer_const_constructors, prefer_final_fields, unused_field, non_constant_identifier_names, duplicate_ignore, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/home/home_screen.dart';

// ignore: non_constant_identifier_names
enum LoginScreen {
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FROM_WIDGET,
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  showMobilePhoneWidget(context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('asseats/background.jpeg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Verify Your Phone Number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Enter Your PhoneNumber"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await _auth.verifyPhoneNumber(
                      phoneNumber: "+91${phoneController.text}",
                      verificationCompleted: (phoneAuthCredential) async {},
                      verificationFailed: (verificationFailed) {
                        print(verificationFailed);
                      },
                      codeSent: (verificationID, resendingToken) async {
                        setState(() {
                          currentState = LoginScreen.SHOW_OTP_FROM_WIDGET;
                          this.verificationID = verificationID;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationID) async {});
                },
                child: Text("Send OTP")),
            SizedBox(
              height: 16,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  showOtpFormWidget(context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('asseats/background.jpeg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "ENTER YOUR OTP",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Enter Your OTP"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationID,
                          smsCode: otpController.text);
                  signInWithPhoneAuthCred(phoneAuthCredential);
                },
                child: Text("Verify")),
            SizedBox(
              height: 16,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
          ? showMobilePhoneWidget(context)
          : showOtpFormWidget(context),
    );
  }
}
