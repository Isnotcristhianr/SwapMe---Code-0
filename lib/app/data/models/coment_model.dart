import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? authId; // Auth ID del usuario que dejó el comentario
  Timestamp? date; // Fecha y hora del comentario
  String? text; // Texto del comentario

  CommentModel({
    this.id,
    this.authId,
    this.date,
    this.text,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      authId: map['authId'],
      date: map['date'],
      text: map['text'],
    );
  }

  factory CommentModel.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String? id) {
    return CommentModel(
      id: id,
      authId: snapshot.data()?['authId'],
      date: snapshot.data()?['date'],
      text: snapshot.data()?['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authId': authId,
      'date': date,
      'text': text,
    };
  }

  // Método para agregar un comentario a Firestore
  static Future<void> addComment(
      String authId, String text) async {
    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'authId': authId,
        'date': FieldValue.serverTimestamp(),
        'text': text,
      });
    } catch (e) {
      // Manejo de errores
      // ignore: avoid_print
      print('Error adding comment: $e');
    }
  }
}
