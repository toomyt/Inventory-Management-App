import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_app/models/item.dart';

class InventoryService {
  final CollectionReference _collection = FirebaseFirestore.instance.collection('inventory');
  Future<void> addItem(ItemModel item) async {
    await _collection.add(item.toMap());
  }
  Stream<List<ItemModel>> streamItems() {
  return _collection.snapshots().map(
    (snap) => snap.docs.map((d) => ItemModel.fromFirestore(d)).toList(),
    );
  }

  Future<void> updateItem(ItemModel item) async {
    await _collection.doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _collection.doc(id).delete();
  }
}


