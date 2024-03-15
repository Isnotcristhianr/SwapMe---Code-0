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
    this.totalRating,
    this.totalSwaps,
  });

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      id: map['id'],
      authId: map['authId'],
      date: map['date'],
      punt: map['punt'],
      totalRating: map['totalRating']?.toDouble(),  // Convertir a double
      totalSwaps: map['totalSwaps'],  // No necesita conversión
    );
  }

  factory RankingModel.fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot, String? id) {
    return RankingModel(
      id: id,
      authId: snapshot.data()?['authId'],
      date: snapshot.data()?['date'],
      punt: (snapshot.data()?['punt'] ?? 0).toDouble(),  // Convertir a double
      totalRating: (snapshot.data()?['totalRating'] ?? 0).toDouble(),  // Convertir a double
      totalSwaps: snapshot.data()?['totalSwaps'] ?? 0,  // No necesita conversión
    );
  }
}
