import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/data/models/user_model.dart';

import '../../../data/models/product_model.dart';

class FavoritesController extends GetxController {
  // to hold the favorite products
  RxList<ProductModel> productsFavorites = List<ProductModel>.empty().obs;
  RxList<ProductModel> productsInNegotiation = List<ProductModel>.empty().obs;
  String messageToDisplay = '';

  @override
  void onReady() {
    getFavoriteProducts();
    super.onReady();
  }

  /// get the favorite products from the product list
  getFavoriteProducts() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(MySharedPref.getCurrentUserId())
        .get()
        .then((value) {
      if (value.exists) {
        UserModel userTmp = UserModel.fromFirebase(value, null);
        FirebaseFirestore.instance
            .collection('products')
            .where('available', isEqualTo: true)
            .get()
            .then((value) {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> myFavorites = value
              .docs
              .where((e) => userTmp.favorites!.contains(e.id))
              .toList();
          productsFavorites.value = myFavorites
              .map((e) {
                ProductModel product = ProductModel.fromFirebase(e, null);
                product.isFavorite = true;
                return product;
              })
              .where((element) => !element.interested!
                  .contains(MySharedPref.getCurrentUserId()))
              .toList();
        // ignore: invalid_return_type_for_catch_error, avoid_print
        }).catchError(print);
        // productsFavorites = userTmp.favorites.map((e) => null);
        // Get all products by id of list
      }
    // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print(error));
  }

  getProductsInNegotiation() {
    FirebaseFirestore.instance
        .collection('products')
        .where('interested', arrayContains: MySharedPref.getCurrentUserId())
        .where('available', isEqualTo: true)
        .get()
        .then((value) {
      productsInNegotiation.value = value.docs
          .map<ProductModel>((e) => ProductModel.fromFirebase(e, null))
          .toList();
    });
  }

  Future<bool> removeProductNegotiation({required ProductModel product}) async {
    bool result = false;
    try {
      product.interested?.remove(MySharedPref.getCurrentUserId());
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .set({'interested': product.interested}, SetOptions(merge: true));
      messageToDisplay = 'Product remove of your interest';
      result = true;
    } catch (e) {
      messageToDisplay = e.toString();
    }
    return result;
  }
}
