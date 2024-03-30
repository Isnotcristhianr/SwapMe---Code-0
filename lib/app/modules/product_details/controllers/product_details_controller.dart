// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

import 'dart:async';

//modelos
import 'package:swapme/app/data/models/user_model.dart';
//ranking model
import 'package:swapme/app/data/models/ranking_model.dart';

class ProductDetailsController extends GetxController {
  String messageToDisplay = '';

  // get product details from arguments
  ProductModel product = Get.arguments;
  Rx<UserModel> userOwner =
      Rx<UserModel>(UserModel(name: '', lastName: '', id: ''));

  //obtener punt de ranking model de un usuario
  Rx<RankingModel> rankingModel = Rx<RankingModel>(RankingModel(punt: 0.0));

  Rx<RankingModel> ownerRanking = Rx<RankingModel>(RankingModel(punt: 0.0));

  @override
  onReady() {
    getOwnerData();
    getOwnerRanking();
    super.onReady();
  }

 Future<void> getOwnerRanking() async {
    try {
      final ownerData = await FirebaseFirestore.instance
          .collection('users')
          .doc(product.ownerId)
          .get();

      if (ownerData.exists) {
        final authId = ownerData.data()?['auth_id'];
        if (authId != null) {
          final rankingData = await FirebaseFirestore.instance
              .collection('ranking')
              .doc(authId)
              .get();

          if (rankingData.exists) {
            ownerRanking.value = RankingModel.fromFirebase(rankingData, authId);
            update(); // Actualiza la vista después de obtener la puntuación del propietario
          }
        }
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }

  Future<void> getOwnerData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(product.ownerId!)
          .get();

      if (snapshot.exists) {
        userOwner.value = UserModel.fromFirebase(snapshot, null);
        update(); // Actualiza la vista después de obtener los datos del usuario propietario
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void fetchOwnerDetails(String ownerId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(ownerId)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        userOwner.value = UserModel.fromFirebase(snapshot, null);
      } else {
        // El propietario no se encontró en Firestore
        // Puedes manejar esta situación según tus requisitos
      }
    }).catchError((error) {
      // Manejar el error si ocurre algún problema al obtener los detalles del propietario
    });
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
      message = '$message ${owner.name} ${owner.lastName}' +
          ' me interesa tu producto ${product.name}.' +
          ' ¿Podemos acordar un intercambio? 🤔';
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

//getratingString
String getRatingString(double rating) {
  if (rating == 0.0) {
    return 'Sin calificación';
  } else if (rating == 1.0) {
    return 'Muy malo';
  } else if (rating == 2.0) {
    return 'Malo';
  } else if (rating == 3.0) {
    return 'Regular';
  } else if (rating == 4.0) {
    return 'Bueno';
  } else if (rating == 5.0) {
    return 'Excelente';
  } else {
    return '';
  }
}
