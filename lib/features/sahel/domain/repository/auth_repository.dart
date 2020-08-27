import 'package:flutter/material.dart';

import '../entities/local_user.dart';

abstract class AuthRepository {
  Future<LocalUser> signInWithGoogle();

  Future<LocalUser> signInWithFacebook();

  Future<void> singInWithPhone(String phone, BuildContext context);

  Future<LocalUser> saveUserToFirestore(LocalUser user, {String phone});

  Future<LocalUser> getCurrentUser();

  Future<void> singOut();
}
