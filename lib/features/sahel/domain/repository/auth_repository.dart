import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../entities/local_user.dart';

abstract class AuthRepository {
  Future<LocalUser> signInWithGoogle();

  Future<LocalUser> signInWithFacebook();

  Future<void> singInWithPhone(String phone, BuildContext context, DocumentReference unitRef);

  Future<LocalUser> saveUserToFirestore(LocalUser user, {String phone});

  LocalUser getCurrentUser();

  Stream<LocalUser> getCurrentUserStream(String uid);

  Future<void> singOut();
}
