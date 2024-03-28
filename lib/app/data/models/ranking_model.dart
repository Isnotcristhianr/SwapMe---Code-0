import 'package:cloud_firestore/cloud_firestore.dart';

class RankingModel {
  String? id;
  String? authId;
  Timestamp? date;
  double? punt;
  double? totalRating;
  int? totalSwaps;

  RankingModel({
    this.id,
    this.authId,
    this.date,
    this.punt,
    this.totalSwaps,
  });

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      id: map['id'],
      authId: map['authId'],
      date: map['date'],
      punt: map['punt'],
      totalSwaps: map['totalSwaps'], // No necesita conversión
    );
  }

  factory RankingModel.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String? id) {
    return RankingModel(
      id: id,
      authId: snapshot.data()?['authId'],
      date: snapshot.data()?['date'],
      punt: (snapshot.data()?['punt'] ?? 0).toDouble(), // Convertir a double
      totalSwaps: snapshot.data()?['totalSwaps'] ?? 0, // No necesita conversión
    );
  }

  //buscar el puntaje de un usuario en especifico
  static Future<double?> findUserPunt(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('ranking')
          .where('authId', isEqualTo: userId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return RankingModel.fromFirebase(
                snapshot.docs.first, snapshot.docs.first.id)
            .punt;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error finding user punt: $e');
    }
    return 0;
  }
}
