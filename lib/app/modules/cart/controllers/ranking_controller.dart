import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RankingController extends GetxController {
  double calculateNewRating(double currentRating, double newRating, int totalSwaps) {
    // Calcular el nuevo puntaje
    double updatedRating = ((currentRating * totalSwaps) + newRating) / (totalSwaps + 1);
    return updatedRating;
  }
}
