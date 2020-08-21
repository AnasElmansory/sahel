import 'package:flutter/material.dart';

import '../../entities/local_user.dart';
import '../../repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  const AuthUseCase(this._authRepository);

  Future<LocalUser> facebookAuthCall() => _authRepository.signInWithFacebook();

  Future<LocalUser> googleAuthCall() => _authRepository.signInWithGoogle();

  Future<LocalUser> phoneAuthCall(String phone, BuildContext context) =>
      _authRepository.singInWithPhone(phone, context);
}
