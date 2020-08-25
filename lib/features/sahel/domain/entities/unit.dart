import 'package:cloud_firestore/cloud_firestore.dart';

class Unit {
  final String name;
  final String description;
  final int price;
  final List<dynamic> images;
  final double longitude;
  final double latitude;
  final DocumentReference unAvailableDays;

  const Unit({
    this.longitude,
    this.latitude,
    this.name,
    this.description,
    this.price,
    this.images,
    this.unAvailableDays,
  });
}
