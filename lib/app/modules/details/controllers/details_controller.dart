import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsController extends GetxController {
  RxString userName = RxString('');
  RxString userPhoto = RxString('');

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

//nombre del authid del usuario 
  Future<String?> getUserById(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('auth_id', isEqualTo: authId)
          .limit(
              1) 
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        return userSnapshot.docs.first.data()['name'];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user by id: $e');
    }
    return null; 
  }

  //demas datos del usuario
  Future<String?> getUserPhotoById(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('auth_id', isEqualTo: authId)
          .limit(
              1) 
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        return userSnapshot.docs.first.data()['photo'];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user by id: $e');
    }
    return null; 
  }

  //obtener comentarios y fecha por el auth id
  Future<List<Map<String, dynamic>>> getFeedbackByAuthId(String authId) async {
    try {
      final feedbackSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('auth_id', isEqualTo: authId)
          .get();

      if (feedbackSnapshot.docs.isNotEmpty) {
        return feedbackSnapshot.docs.map((doc) {
          return {
            'comment': doc.data()['comment'],
            'date': doc.data()['date'],
          };
        }).toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching feedback by authId: $e');
    }
    return []; 
  }
  
}
