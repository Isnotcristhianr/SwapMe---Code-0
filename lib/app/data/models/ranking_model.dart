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
  final data = snapshot.data();
  final commentsData = data?['comments'];

  return RankingModel(
    id: id,
    authId: data?['authId'],
    date: data?['date'],
    punt: (data?['punt'] ?? 0).toDouble(),
    totalSwaps: (data?['totalSwaps'] ?? 0).toInt(),
    comments: commentsData is Iterable<dynamic>
        ? List<String>.from(commentsData)
        : commentsData != null 
            ? [commentsData.toString()] // If it's a string, create a list with it
            : [], // If it's null, use an empty list
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
