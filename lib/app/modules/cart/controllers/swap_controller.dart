import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:swapme/app/data/models/product_model.dart';
import 'package:swapme/app/data/models/user_model.dart';

class SwapController extends GetxController {
  ProductModel product = Get.arguments;

  RxList<UserModel> usersMaybeOwners = RxList.empty();

  @override
  void onReady() {
    getUsersInterested();
    super.onReady();
  }

  getUsersInterested() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> interested =
          value.docs.where((e) => product.interested!.contains(e.id)).toList();
      usersMaybeOwners.value = interested.map((e) {
        UserModel product = UserModel.fromFirebase(e, null);
        return product;
      }).toList();
    // ignore: invalid_return_type_for_catch_error, avoid_print
    }).catchError(print);
    update();
  }


  // ignore: non_constant_identifier_names
  confirmSwap({required String owner_id}) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .set({
      'available': false,
      'newOwner_id': owner_id,
    }, SetOptions(merge: true));
  }
}
