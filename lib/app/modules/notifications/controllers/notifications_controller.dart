import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//ranking model
import 'package:swapme/app/data/models/ranking_model.dart';
//user model
import 'package:swapme/app/data/models/user_model.dart';

class NotificationsController extends GetxController {
  RxList<RankingModel> topUsers = <RankingModel>[].obs;
  RxList<UserModel> users = <UserModel>[].obs;

  Rx<UserModel> usersName = Rx<UserModel>(UserModel(name: ""));

  @override
  void onInit() {
    super.onInit();
    //datos del ranking
    getTopUsers();
    //datos de los usuarios
    getUsers();
  }

  Future<void> getTopUsers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('ranking')
          .orderBy('punt', descending: true)
          .limit(3)
          .get();
      if (snapshot.docs.isNotEmpty) {
        topUsers.value = snapshot.docs
            .map((doc) => RankingModel.fromFirebase(doc, doc.id))
            .toList();

        // Obtener la lista de usuarios correspondiente
        await getUsers();
      }
    } catch (e) {
      // Manejar el error
      // ignore: avoid_print
      print('Error fetching top users: $e');
    }
  }

  Future<void> getUsers() async {
    try {
      final userIds = topUsers.map((user) => user.authId).toList();

      // Verificar que userIds no esté vacío antes de ejecutar la consulta
      if (userIds.isNotEmpty) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, whereIn: userIds)
            .get();

        if (snapshot.docs.isNotEmpty) {
          users.value = snapshot.docs
              .map((doc) =>
                  UserModel.fromFirebase(doc, doc.id as SnapshotOptions?))
              .toList();
        }
      }
    } catch (e) {
      // Manejar el error
      // ignore: avoid_print
      print('Error fetching users: $e');
    }
  }

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
}
