import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapme/app/data/models/user_model.dart';

class ProductModel {
  String? id;
  String? image;
  String? name;
  int? quantity;
  double? price;
  int? rating;
  String? reviews;
  String? size;
  bool? isFavorite;
  String? ownerId; // The owner principal
  String? newOwnerId;
  bool available;
  List<String>? interested;

  UserModel? owner, newOwner;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.quantity,
    this.price,
    this.rating,
    this.reviews,
    this.size,
    this.isFavorite,
    this.ownerId,
    this.available = false,
    this.newOwnerId,
    this.interested,
    this.owner,
    this.newOwner,
  });

  factory ProductModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      id: data?['id'] ?? snapshot.id,
      name: data?['name'],
      image: data?['image'], //data?['image'],
      quantity: data?['quantity'],
      price: double.tryParse(data?['price'].toString() ?? '0'),
      size: data?['size'],
      rating: data?['rating'] ?? 0,
      reviews: data?['reviews'] ?? 'Sin review',
      isFavorite: data?['is_favorite'],
      ownerId: data?['owner_id'],
      available: data?['available'] ?? true,
      newOwnerId: data?['newOwner_id'],
      interested: List<String>.from(data?['interested'] ?? []),
    );
  }
  factory ProductModel.fromMap(
    Map<String, dynamic> data,
    SnapshotOptions? options,
  ) {
    return ProductModel(
      id: data['id'],
      name: data['name'],
      image: data['image'], //data?['image'],
      quantity: data['quantity'],
      price: double.tryParse(data['price'].toString()),
      size: data['size'],
      rating: data['rating'].toDouble() ?? 0.0,
      reviews: data['reviews'] ?? 'Sin review',
      isFavorite: data['is_favorite'],
      ownerId: data['owner_id'],
      available: data['available'] ?? true,
      newOwnerId: data['newOwner_id'],
    );
  }

  Map<String, dynamic> toJSON() => {
        'name': name,
        'image': image,
        'quantity': 1,
        'price': price,
        'size': size,
        'rating': rating,
        'reviews': reviews,
        'is_favorite': false,
        'owner_id': ownerId,
        'available': true,
        'newOwner_id': null,
        'interested': [],
      };
}
