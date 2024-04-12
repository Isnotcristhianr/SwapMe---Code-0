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

  Future<void> fetchUserData(String authId) async {
  isLoading.value = true; // Indicar que se está cargando
  try {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data();
      userName.value = userData?['name'] ?? ''; // Usa el operador '?' para manejar nulos
      userPhoto.value = userData?['photo'] ?? '';
      isLoading.value = false; // Indicar que se ha cargado exitosamente
    } else {
      // ignore: avoid_print
      print('User document does not exist');
      isLoading.value = false; // Indicar que se ha terminado la carga con error
    }
  } catch (e) {
    // Handle error
    // ignore: avoid_print
    print('Error fetching user data: $e');
    isLoading.value = false; // Indicar que se ha terminado la carga con error
  }
}
}
