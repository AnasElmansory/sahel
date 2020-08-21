import 'package:cloud_firestore/cloud_firestore.dart';

class LocalUser {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final Timestamp lastTimeSignIn;
  final String phoneNumber;
  final List favs;

  const LocalUser({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.lastTimeSignIn,
    this.phoneNumber,
    this.favs,
  });
}
