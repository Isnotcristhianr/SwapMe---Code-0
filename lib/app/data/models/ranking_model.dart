import 'package:cloud_firestore/cloud_firestore.dart';

class RankingModel {
  String? id;
  String? authId;
  Timestamp? date;
  double? punt;
  double? totalRating;
  int? totalSwaps;
  //comentarios
  List<String>? comments;

  RankingModel({
    this.id,
    this.authId,
    this.date,
    this.punt,
    this.totalSwaps,
    //comentarios
    this.comments,
  });

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      id: map['id'],
      authId: map['authId'],
      date: map['date'],
      punt: map['punt'],
      totalSwaps: map['totalSwaps'], // No necesita conversión
      //comentarios
      comments: List<String>.from(
          map['comments']), // Convierte la lista de comentarios
    );
  }

  factory RankingModel.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String? id) {
    return RankingModel(
      id: id,
      authId: snapshot.data()?['authId'],
      date: snapshot.data()?['date'],
      punt: (snapshot.data()?['punt'] ?? 0).toDouble(), // Convertir a double
      totalSwaps:
          (snapshot.data()?['totalSwaps'] ?? 0).toInt(), // Convert to int
      //comentarios
      comments: List<String>.from(
          snapshot.data()?['comments']), // Convierte la lista de comentarios
    );
  }

  get name => null;

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
