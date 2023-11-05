// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;
  Rx<UserModel> userOwner = Rx<UserModel>(UserModel(name: '', lastName: ''));

  String messageToDisplay = '';

  @override
  onReady() {
    getOwnerData();
    super.onReady();
  }

  getOwnerData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(product.ownerId!)
        .get()
        .then((value) => {userOwner.value = UserModel.fromFirebase(value, null)})
        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError(print);
  }

  /// when the user press on the favorite button
  onFavoriteButtonPressed() {
    Get.find<BaseController>().onFavoriteButtonPressed(product: product);
    update(['FavoriteButton']);
  }

  Uri getUrl({phone = '', message = ''}) {
    String url = '';
    if (Platform.isAndroid) {
      // add the [https]
      url = "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
    return Uri.parse(url);
  }

  /// when the user press on add to cart button
  Future<bool> onAddToCartPressed() async {
    // Launch Whatsapp
    String? phone = '', message = 'Hola, ';
    bool result = false;
    try {
      final value = await FirebaseFirestore.instance
          .collection('users')
          .doc(product.ownerId)
          .get();
      UserModel owner = UserModel.fromFirebase(value, null);
      phone = owner.phone;
      if (phone == null) {
        messageToDisplay = 'El dueño no tiene telefono registrado';
        return false;
      }
      // ignore: 
      message = '$message ${owner.name} ${owner.lastName}'  + ' me interesa tu producto ${product.name}.' + ' ¿Podemos acordar un intercambio? 🤔';
      Uri url = getUrl(phone: phone, message: message);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
        result = true;
        // Add to interested
        String userInterested = MySharedPref.getCurrentUserId()!;
        if (!product.interested!.contains(userInterested)) {
          product.interested!.add(userInterested);
          await FirebaseFirestore.instance
              .collection('products')
              .doc(product.id)
              .set(
                  {'interested': product.interested!}, SetOptions(merge: true));
        }
      } else {
        messageToDisplay = 'Whatsapp not installed';
        result = false;
      }
    } catch (e) {
      messageToDisplay = e.toString();
      result = false;
    }

    return result;
  }

  //talla seleccionada
  var selectedSize = 'S'.obs;
  
}
