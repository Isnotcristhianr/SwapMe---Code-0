import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//intl

class UserDetailsController extends GetxController {
  RxString userName = RxString('');
  RxString userPhoto = RxString('');
  RxDouble userPunt = RxDouble(0);
  RxInt userTotalSwaps = RxInt(0);
  RxBool isLoading = RxBool(true); // Para controlar el estado de carga

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  //obtener el nombre del usuario por el authId
  // Función para obtener el nombre del usuario por authId
  Future<String?> getUserById(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('auth_id', isEqualTo: authId)
          .limit(
              1) // Limitar a 1 documento, ya que debería haber solo un usuario con el mismo authId
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Obtener el nombre del usuario del primer documento encontrado
        return userSnapshot.docs.first.data()['name'];
      }
    } catch (e) {
      // Manejar el error
      // ignore: avoid_print
      print('Error fetching user by id: $e');
    }
    return null; // Retorna null si no se encuentra el usuario
  }

  //obtener foto del usuario por el authId
  // Función para obtener la foto del usuario por authId
  Future<String?> getUserPhotoById(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('auth_id', isEqualTo: authId)
          .limit(
              1) // Limitar a 1 documento, ya que debería haber solo un usuario con el mismo authId
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Obtener la foto del usuario del primer documento encontrado
        return userSnapshot.docs.first.data()['photo'];
      }
    } catch (e) {
      // Manejar el error
      // ignore: avoid_print
      print('Error fetching user photo by id: $e');
    }
    return null; // Retorna null si no se encuentra la foto del usuario
  }

  //puntaje
  // Función para obtener el puntaje del usuario por authId desde el ranking
  Future<double> getUserScore(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('ranking')
          .where('authId', isEqualTo: authId)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userScore = userSnapshot.docs.first.data()['punt'] ?? 0.0;
        return userScore;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener el puntaje del usuario: $e');
    }
    return 0.0;
  }

  //total intercambios
  // Función para obtener el total de intercambios del usuario por authId desde el ranking
  Future<int> getUserTotalSwaps(String authId) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('ranking')
          .where('authId', isEqualTo: authId)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final totalSwaps = userSnapshot.docs.first.data()['totalSwaps'] ?? 0;
        return totalSwaps;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener el total de intercambios del usuario: $e');
    }
    return 0;
  }

// Función para obtener los comentarios del usuario por authId
  Future<List<Map<String, dynamic>>> getUserComments(String authId) async {
    try {
      final commentSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('authId', isEqualTo: authId)
          .orderBy('date', descending: true)
          .get();

      if (commentSnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> comments = commentSnapshot.docs.map((doc) {

          return {
            'comment': doc.data()['text'] as String,
            'date': doc.data()['date'] as Timestamp,
          };
        }).toList();
        return comments;
      }
    } catch (e) {
      // Manejar el error
      print('Error fetching user comments: $e');
    }
    return []; // Retornar una lista vacía si no hay comentarios
  }
}
