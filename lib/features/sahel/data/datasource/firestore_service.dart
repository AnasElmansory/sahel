import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/data/models/user_model.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUnitsListStream() =>
      _firestore.collection('units').snapshots();

  Future<DocumentSnapshot> saveUserProfile(UserModel user,
      {String phone}) async {
    final _ref = _firestore.collection('users').doc(user.uid);
    await _ref.set(UserModel.toJson(user, phone: phone));
    return await _ref.get();
  }

  Stream<DocumentSnapshot> getDaysEvents(DocumentReference unitRef) =>
      unitRef.snapshots();

  Future<void> updateCalenderEvents(
          Map data, DocumentReference placeRef) async =>
      data.forEach((key, value) async {
        await placeRef.update({
          'unAvailableDays': FieldValue.arrayUnion([
            {key: value}
          ])
        });
      });
}
