import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/coment_model.dart';

class CommentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para agregar un comentario a Firestore
  Future<DocumentReference> addComment({
    required String authId,
    required String text,
  }) async {
    try {
      DocumentReference commentRef =
          await _firestore.collection('comments').add({
        'authId': authId,
        'date': FieldValue.serverTimestamp(),
        'text': text,
      });
      return commentRef;
    } catch (e) {
      // ignore: avoid_print
      print('Error adding comment: $e');
      throw Exception('Failed to add comment');
    }
  }

  // Método para obtener todos los comentarios de un usuario
  Future<List<CommentModel>> getCommentsByUser(String authId) async {
    try {
      QuerySnapshot commentSnapshot = await _firestore
          .collection('comments')
          .where('authId', isEqualTo: authId)
          .orderBy('date', descending: true)
          .get();

      List<CommentModel> comments = commentSnapshot.docs
          .map((doc) => CommentModel.fromFirebase(doc as DocumentSnapshot<Map<String, dynamic>>, doc.id))
          .toList();

      return comments;
    } catch (e) {
      // ignore: avoid_print
      print('Error getting comments: $e');
      throw Exception('Failed to get comments');
    }
  }

  // Método para eliminar un comentario
  Future<void> deleteComment(String commentId) async {
    try {
      await _firestore.collection('comments').doc(commentId).delete();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting comment: $e');
      throw Exception('Failed to delete comment');
    }
  }
}
