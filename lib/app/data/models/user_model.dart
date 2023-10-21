import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  String? authId; // Auth firenase
  String? photo;
  String? verifyCode;
  String? password;
  List<String>? favorites;
  String? genere;

  UserModel({
    this.id = '',
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.authId = '',
    this.photo = '',
    this.favorites,
    this.genere = '',
  });

  factory UserModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: snapshot.id,
      name: data?['name'],
      lastName: data?['lastname'],
      email: data?['email'],
      phone: data?['phone'],
      authId: data?['auth_id'],
      photo: data?['photo'],
      favorites: List<String>.from(data?['favorites'] ?? []),
      genere: data?['genere'],
    );
  }

  Map<String, dynamic> toJSON() => {
        'name': name,
        'lastname': lastName,
        'email': email,
        'phone': phone,
        'auth_id': authId,
        'photo': photo,
        'favorites': [],
        'genere': genere,
      };
}
