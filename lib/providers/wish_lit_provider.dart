import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class WishListProvider with ChangeNotifier {
  addWishListData({
    required String wishListId,
    required String wishListName,
    required var wishListPrice,
    required String wishListImage,
  }) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set({
      "wishListId": wishListId,
      "wishListName": wishListName,
      "wishListImage": wishListImage,
      "wishListPrice": wishListPrice,
    });
  }

///// Get WishList Data ///////
  List<ProductModel> wishList = [];

  getWishtListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    value.docs.forEach(
      (element) {
        ProductModel productModel = ProductModel(
          productId: element.get("wishListId"),
          productImage: element.get("wishListImage"),
          productName: element.get("wishListName"),
          productPrice: element.get("wishListPrice"),
          productUnit: [1],
        );
        newList.add(productModel);
      },
    );
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

////////// Delete WishList /////
  deleteWishtList(wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}
