import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:sahel/domain/entities/local_user.dart';

abstract class LoginRepository {
  Future<LocalUser> signInWithGoogle();

  Future<LocalUser> signInWithFacebook();

  Future<LocalUser> singInWithPhone(String phone, BuildContext context);

  Future<void> saveUserProfile(LocalUser user);

  LocalUser getCurrentUser();

  Future<void> singOut();
}
