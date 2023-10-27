import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import 'package:swapme/app/data/models/user_model.dart';
import 'package:video_player/video_player.dart';

class LoginController extends GetxController {
  UserModel user = UserModel();
  String messageToDisplay = '';
  String titleMessage = ' ';
  bool isRestorePasswprd = false;
  RxBool isLoading = RxBool(false);


  Future<bool> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);
    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredentials =
            await FirebaseAuth.instance.signInWithCredential(credential);
        // ignore: avoid_print
        print(userCredentials);
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return false;
      }
    }
    return false;
  }

  Future<bool> restorePassword() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
      messageToDisplay = 'Check you email. The code to reset password was sent';
      isRestorePasswprd = true;
      return true;
    } on FirebaseAuthException catch (e) {
      messageToDisplay = e.message!;
      return false;
    }
  }

  Future<bool> confirmRestorePassword(String newPassword) async {
    try {
      FirebaseAuth.instance.confirmPasswordReset(
          code: user.verifyCode!, newPassword: newPassword);

      return true;
    } on FirebaseAuthException catch (e) {
      messageToDisplay = e.message!;
      return false;
    }
  }

  Future<bool> login() async {
    try {
      isLoading.value = true;
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      final userLogin = credential.user;
      user.authId = userLogin?.uid;
      if (!(credential.user!.emailVerified)) {
        messageToDisplay =
            'The user is not actived. Active you account with email';
        return false;
      }

      return true;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.code);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        messageToDisplay = 'Invalid password. Check your password or restore.';
      } else {
        messageToDisplay = e.message!;
        titleMessage = e.code;
      }
      return false;
    }
  }

  Future<bool> isRegisterEmail() async {
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('users')
          .where('email', isEqualTo: user.email!)
          .get();
      return data.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

}
