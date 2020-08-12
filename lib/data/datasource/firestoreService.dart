import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestore = Firestore.instance;

  Stream unitStream() {
    Stream _stream = _firestore.collection('units').snapshots();
    return _stream;
  }
}
