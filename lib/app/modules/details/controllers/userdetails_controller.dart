import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsController extends GetxController {
  RxString userName = RxString('');
  RxString userPhoto = RxString('');
  RxDouble userPunt = RxDouble(0);
  RxInt userTotalSwaps = RxInt(0);
  RxBool isLoading = RxBool(true); // Para controlar el estado de carga

  @override
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
}
