import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel{
  final String id;
  final String name;
  final double price;
  final int quantity;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
