// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print, await_only_futures, avoid_function_literals_in_foreach_calls, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final CollectionReference imageList =
      FirebaseFirestore.instance.collection('imageInfo');

  Future createDatabase(
      String PRoductImage, String PRoductName, int PRoductPrice) async {
    var documentReference = await imageList.add({
      PRoductImage:
          'https://www.pngarts.com/files/4/Ginger-PNG-Download-Image.png',
      PRoductName: 'Fresh Basil',
      PRoductPrice: '50'
    });
    return documentReference;
  }

  Future getList() async {
    List imagelist = [];

    try {
      await imageList.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          imagelist.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

/*Future getList() async {
  try {
    await imageList.get;
  } catch (e) {
    print(e.toString());
    return null;
  }
}*/
