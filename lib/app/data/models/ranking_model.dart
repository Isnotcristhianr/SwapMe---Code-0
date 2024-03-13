// ignore: unused_import
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';


class RankingModel{
  String? id;
  Timestamp? date;
  double? punt;

  RankingModel({
    this.id = '',
    this.date,
    this.punt,
  });


  factory RankingModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RankingModel(
      id: snapshot.id,
      date: data?['date'],
      punt: data?['punt'],
    );
  }

  Map<String, dynamic> toJSON() => {
        'date': date,
        'punt': punt,
      };
  

}