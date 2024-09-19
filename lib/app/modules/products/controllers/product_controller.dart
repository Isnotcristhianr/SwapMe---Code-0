import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/data/models/product_model.dart';

class ProductController extends GetxController {
  RxString image = RxString('');

  ProductModel product = ProductModel();

  String title = '';
  String messageToDisplay = '';
  RxBool isLoading = RxBool(false);

  // Upload image

  Future<bool> registerProduct() async {
    try {
      isLoading.value = true;
      product.ownerId = MySharedPref.getCurrentUserId();
      if (product.image!.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref();
        final mountainsRef =
            storageRef.child('products/${product.image!.split('/').last}');
        File file = File(product.image!);
        await mountainsRef.putFile(file);

        product.image = await mountainsRef.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('products')
          .add(product.toJSON());

      title = 'Product Registered';
      messageToDisplay = 'Product registered sucessfully';
      return true;
    } catch (e) {
      title = 'Error Register';
      messageToDisplay = e.toString();
      return false;
    }
  }
}
