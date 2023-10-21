import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/data/models/user_model.dart';

import '../../../data/models/product_model.dart';

class CartController extends GetxController {
  RxList<ProductModel> products = RxList.empty();
  RxList<ProductModel> productsSwapped = RxList.empty();
  String messageToDisplay = '';

  @override
  void onReady() async {
    // Get all products owner and are available
    await getCartProducts();
    await getProductsSwapped();
    super.onReady();
  }

  getCartProducts() async {
    final value = await FirebaseFirestore.instance
        .collection('products')
        .where('owner_id', isEqualTo: MySharedPref.getCurrentUserId())
        .where('available', isEqualTo: true)
        .get();
    products.value = value.docs
        .map((product) => ProductModel.fromFirebase(product, null))
        .toList();
  }

  getProductsSwapped() async {
    List<ProductModel> tmp = List.empty(growable: true);

    final value = await FirebaseFirestore.instance
        .collection('products')
        .where('owner_id', isEqualTo: MySharedPref.getCurrentUserId())
        .where('newOwner_id', isNotEqualTo: null)
        .where('available', isEqualTo: false)
        .get();
    tmp.addAll(value.docs.map((product) {
      ProductModel productModel = ProductModel.fromFirebase(product, null);
      FirebaseFirestore.instance
          .collection('users')
          .doc(productModel.newOwnerId)
          .get()
          .then(
            (value) =>
                productModel.newOwner = UserModel.fromFirebase(value, null),
          );
      return productModel;
    }).toList());

    final value2 = await FirebaseFirestore.instance
        .collection('products')
        .where('newOwner_id', isEqualTo: MySharedPref.getCurrentUserId())
        .where('available', isEqualTo: false)
        .get();
    final listTmp = await Future.wait(value2.docs.map((product) async {
      ProductModel productModel = ProductModel.fromFirebase(product, null);
      final userTmp = await FirebaseFirestore.instance
          .collection('users')
          .doc(productModel.ownerId)
          .get();
      productModel.owner = UserModel.fromFirebase(userTmp, null);
      return productModel;
    }).toList());

    tmp.addAll(listTmp);

    productsSwapped.value = tmp;
  }

  Future<bool> deleteProduct({required String id}) async {
    bool result = false;
    try {
      await FirebaseFirestore.instance.collection('products').doc(id).delete();
      messageToDisplay = 'Produc deleted successfully';
      result = true;
    } catch (e) {
      messageToDisplay = e.toString();
      result = false;
    }
    return result;
  }
}
