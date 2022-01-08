import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();

  LocationData? setLoaction;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "MobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "AlternateMobileNo is empty");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "Scoiety is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "Landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "Aera is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "Pincode is empty");
    } else if (pincode.text.length != 6) {
      Fluttertoast.showToast(msg: "Enter Correct Pincode");
    } else if (mobileNo.text.length != 10) {
      Fluttertoast.showToast(msg: "Enter Correct Mobile Number ");
    } else if (alternateMobileNo.text.length != 10) {
      Fluttertoast.showToast(msg: "Enter Correct Alternate Mobile Number ");
    } else if (setLoaction == null) {
      Fluttertoast.showToast(msg: "Please Set The Location");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
        "longitude": setLoaction?.longitude,
        "latitude": setLoaction?.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your Delivery address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
          firstName: _db.get("firstname"),
          lastName: _db.get("lastname"),
          mobileNo: _db.get("mobileNo"),
          alternateMobileNo: _db.get("alternateMobileNo"),
          scoiety: _db.get("scoiety"),
          street: _db.get("street"),
          landmark: _db.get("landmark"),
          city: _db.get("city"),
          aera: _db.get("aera"),
          addressType: _db.get("addressType"),
          pincode: _db.get("pincode"));
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressDataList {
    return deliveryAddressList;
  }
}
