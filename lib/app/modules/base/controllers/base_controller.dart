import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/data/models/product_model.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/cart/controllers/cart_controller.dart';
import 'package:swapme/app/modules/home/controllers/home_controller.dart';
import 'package:swapme/app/modules/settings/controllers/settings_controller.dart';

import '../../favorites/controllers/favorites_controller.dart';

class BaseController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  @override
  void onReady() {
    // Get data of user
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        user.value = UserModel.fromFirebase(value.docs[0], null);
        MySharedPref.saveUser(value.docs[0].id);
        SettingsController settingsController = Get.find();
        Get.put(settingsController);
        settingsController.user.value = user.value;
        Get.find<HomeController>().getProducts();
      }
    }).catchError((error) => print('Error in get user ${error.toString()}'));

    super.onReady();
  }

  // current screen index
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    switch (currentIndex) {
      case 0:
        HomeController getHome = Get.find();
        getHome.getProducts();
        break;

      case 1:
        FavoritesController favoritesController = Get.find();
        favoritesController.getFavoriteProducts();
        favoritesController.getProductsInNegotiation();
        break;

      case 2:
        CartController cartController = Get.find();
        cartController.getCartProducts();
        cartController.getProductsSwapped();
        break;
      default:
    }
    update();
  }

  /// when the user press on the favorite button in the product
  onFavoriteButtonPressed({required ProductModel product}) {
    List<String> favorites = user.value.favorites!;

    if (favorites.contains(product.id)) {
      favorites.remove(product.id);
      product.isFavorite = false;
    } else {
      favorites.add(product.id!);
      product.isFavorite = true;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(MySharedPref.getCurrentUserId())
        .set({'favorites': favorites}, SetOptions(merge: true))
        .then((value) {})
        .catchError(print);

    FavoritesController favoritesController = Get.find();
    favoritesController.getFavoriteProducts();
    HomeController homeController = Get.find();
    homeController.getProducts();
    update(['FavoriteButton']);
    update();
  }
}
