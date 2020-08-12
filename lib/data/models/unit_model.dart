import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/domain/entities/unit.dart';

class UnitModel extends Unit {
  UnitModel({String name, String description, int price, List<dynamic> images})
      : super(
            name: name, description: description, price: price, images: images);
  factory UnitModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UnitModel(
        name: snapshot.data['name'],
        description: snapshot.data['description'],
        price: snapshot.data['price'],
        images: snapshot.data['images']);
  }
}
