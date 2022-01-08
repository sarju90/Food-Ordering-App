import 'package:flutter/cupertino.dart';

class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobileNo;
  String alternateMobileNo;
  String scoiety;
  String street;
  String landmark;
  String city;
  String aera;
  String pincode;
  String addressType;

  DeliveryAddressModel({
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.alternateMobileNo,
    required this.scoiety,
    required this.street,
    required this.landmark,
    required this.city,
    required this.aera,
    required this.addressType,
    required this.pincode,
  });
}
