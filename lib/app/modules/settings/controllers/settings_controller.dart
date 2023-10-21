import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/user_model.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  String newImage = '';
  String messageToDisplay = '';
  RxBool isLoading = RxBool(false);

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
      messageToDisplay = 'Information updated successfully';
      result = true;
    } catch (e) {
      messageToDisplay = e.toString();
      result = false;
    }
    return result;
  }
}
