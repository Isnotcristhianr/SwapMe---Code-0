import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsController extends GetxController {
  RxString userName = RxString('');
  RxString userPhoto = RxString('');

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(authId)
          .get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        userName.value = userData['name'];
        userPhoto.value = userData['photo'];
      }
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print('Error fetching user data: $e');
    }
  }
}
