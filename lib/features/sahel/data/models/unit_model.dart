import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';

class UnitModel extends Unit {
  static final _firestore = FirebaseFirestore.instance;
  UnitModel(
      {String name,
      String description,
      int price,
      List<dynamic> images,
      double latitude,
      double longitude,
      DocumentReference unAvailableDays})
      : super(
          longitude: longitude,
          latitude: latitude,
          name: name,
          description: description,
          price: price,
          images: images,
          unAvailableDays: unAvailableDays,
        );
  factory UnitModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> _snapshot = snapshot.data();
    return UnitModel(
      name: _snapshot['name'],
      description: _snapshot['description'],
      price: _snapshot['price'],
      images: _snapshot['images'],
      longitude: _snapshot['longitude'] ?? null,
      latitude: _snapshot['latitude'] ?? null,
      unAvailableDays: _snapshot['unAvailableDays'],
    );
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      images: json['images'],
      longitude: json['longitude'] ?? null,
      latitude: json['latitude'] ?? null,
      unAvailableDays: _firestore.doc(json['unAvailableDays']),
    );
  }
  static Map<String, dynamic> toJson(UnitModel unit) => {
        'name': unit.name,
        'description': unit.description,
        'price': unit.price,
        'images': unit.images,
        'latitude': unit.latitude,
        'longitude': unit.longitude,
        'unAvailableDays': unit.unAvailableDays.path,
      };
}
