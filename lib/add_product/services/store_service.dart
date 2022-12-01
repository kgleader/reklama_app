import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reklama_app/model/product_model.dart';

class StoreService {
  final db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) async {
    await db.collection("products").add(product.toMap());
  }
}
