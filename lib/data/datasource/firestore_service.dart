import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/data/models/user_model.dart';
import 'package:sahel/domain/entities/local_user.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUnitsListStream() =>
      _firestore.collection('units').snapshots();

  Future<void> saveUserProfile(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson(user));
  }
}
