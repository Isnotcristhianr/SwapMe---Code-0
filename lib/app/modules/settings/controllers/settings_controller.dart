// ignore: unused_import
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
//user model
import 'package:swapme/app/data/models/user_model.dart';
//ranking model
import 'package:swapme/app/data/models/ranking_model.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  String newImage = '';
  String messageToDisplay = '';
  RxBool isLoading = RxBool(false);

  //ranking model
  Rx<RankingModel> ranking = RankingModel().obs;

  // get is light theme from shared pref
  var isLightTheme = MySharedPref.getThemeIsLight();

  /// change the system theme
  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

  Future<bool> updateUser() async {
    //
    bool result = false;
    isLoading.value = true;
    try {
      // Update image
      if (newImage != user.value.photo) {
        if (user.value.photo!.isNotEmpty) {
          await FirebaseStorage.instance.refFromURL(user.value.photo!).delete();
        }
        final storageRef = FirebaseStorage.instance.ref();
        final photoRef = storageRef.child('users/${newImage.split('/').last}');
        File file = File(newImage);
        await photoRef.putFile(file);
        user.value.photo = await photoRef.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.value.id)
          .set({
        'name': user.value.name,
        'lastname': user.value.lastName,
        'phone': user.value.phone,
        'photo': user.value.photo,
      }, SetOptions(merge: true));
      messageToDisplay = 'Información actualizada correctamente';
      result = true;
    } catch (e) {
      messageToDisplay = e.toString();
      result = false;
    }
    return result;
  }

  Stream<UserModel> getUser() {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(user.value.id)
        .snapshots()
        .map((event) => UserModel.fromFirebase(event, null));
  }

  //get Ranking, obtener double valor del usuario
  getRanking() {
    FirebaseFirestore.instance
        .collection('ranking')
        .doc(user.value.id)
        .get()
        .then((value) {
      ranking.value = RankingModel.fromFirebase(value, null);
    });
  }

  // Obtener el rating del usuario
 void getRating() {
  FirebaseFirestore.instance
      .collection('ranking')
      .where('authId', isEqualTo: user.value.authId) // Usa user.value.id en lugar de user.value.authId
      .get()
      .then((QuerySnapshot querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;
      ranking.value = RankingModel.fromFirebase(
          document as DocumentSnapshot<Map<String, dynamic>>, null);
    }else {
      ranking.value = RankingModel();
      // ignore: avoid_print
      print( 'No se encontró el ranking del usuario: ${user.value.authId}');
    }
  });
}


  // Escuchar los cambios en el usuario y obtener su rating
  void listenToUserChanges() {
    // Escucha los cambios en el usuario actual
    ever(user, (_) {
      // Cuando cambie el usuario, obtenemos su rating
      getRating();
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Llama al método para escuchar los cambios en el usuario
    listenToUserChanges();
  }
}
