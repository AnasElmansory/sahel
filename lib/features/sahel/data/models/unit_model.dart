import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';

class UnitModel extends Unit {
  UnitModel(
      {String name,
      String description,
      int price,
      List<dynamic> images,
      double latitude,
      double longitude})
      : super(
          longitude: longitude,
          latitude: latitude,
          name: name,
          description: description,
          price: price,
          images: images,
        );
  factory UnitModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> _snapshot = snapshot.data();
    return UnitModel(
        name: _snapshot['name'],
        description: _snapshot['description'],
        price: _snapshot['price'],
        images: _snapshot['images'],
        longitude: _snapshot['longitude'] ?? null,
        latitude: _snapshot['latitude'] ?? null);
  }
}
