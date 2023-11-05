import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/modules/base/controllers/base_controller.dart';

import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  RxList<ProductModel> products = RxList.empty();

  @override
  void onReady() {
    getProducts();
    super.onReady();
  }

  void getProducts() {
    // Get products firebase
    try {
      FirebaseFirestore.instance
          .collection('products')
          .where('owner_id', isNotEqualTo: MySharedPref.getCurrentUserId())
          .where('available', isEqualTo: true)
          .get()
          .then(
        (value) {
          List<ProductModel> tmp = value.docs
              .map((product) => ProductModel.fromFirebase(product, null))
              .toList();
          // User with his favorites

          BaseController baseController = Get.find();
          if (baseController.user.value.favorites != null) {
            products.value = tmp
                .where((e) =>
                    !(baseController.user.value.favorites!.contains(e.id)))
                .toList();
          }
        },
      );
    } catch (e) {
      products.value = [];
    }
  }

}
