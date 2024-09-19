import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/user_model.dart';

class SignUpController extends GetxController {
  UserModel user = UserModel();
  String messageToDisplay = '';
  String titleMessage = ' ';
  RxBool isLoading = RxBool(false);

  Future<bool> registerUser() async {
    try {
      isLoading.value = true;

      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      // Send code to verify
      credential.user?.sendEmailVerification();
      user.authId = credential.user?.uid;

      if (user.photo!.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref();
        final photoRef =
            storageRef.child('users/${user.photo!.split('/').last}');
        File file = File(user.photo!);
        await photoRef.putFile(file);
        user.photo = await photoRef.getDownloadURL();
      }

      // Save to Firestore
      FirebaseFirestore.instance.collection("users").add(user.toJSON()).then(
          (documentSnapshot) =>
              // ignore: avoid_print
              print("Added Data with ID: ${documentSnapshot.id}"));

      messageToDisplay = 'User registered sucessfully';
      return true;
    } on FirebaseAuthException catch (e) {
      messageToDisplay = e.message!;
      // ignore: avoid_print
      print(e);
      return false;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      messageToDisplay = e.toString();
      return false;
    }
  }
}
