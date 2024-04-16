import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RankingController extends GetxController {
  double calculateNewRating(double currentRating, double newRating, int totalSwaps) {
    // Calcular el nuevo puntaje
    double updatedRating = ((currentRating * totalSwaps) + newRating) / (totalSwaps + 1);
    return updatedRating;
  }

  // Método para agregar el ID del comentario al documento de ranking del usuario
  Future<void> addCommentIdToRanking(String userId, String commentId) async {
    try {
      var rankingRef = FirebaseFirestore.instance.collection('ranking').doc(userId);
      await rankingRef.update({
        'comments': FieldValue.arrayUnion([commentId]),
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error adding comment ID to ranking: $e');
    }
  }
}
