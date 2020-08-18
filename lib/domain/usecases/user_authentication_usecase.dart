import 'package:flutter/cupertino.dart';
import 'package:sahel/domain/entities/local_user.dart';
import 'package:sahel/domain/repository/login_repository.dart';

class UserAuthenticationUseCase {
  final LoginRepository _loginRepository;
  UserAuthenticationUseCase(this._loginRepository);

  // ignore: missing_return
  Future<LocalUser> call(String _provider,
      {BuildContext context, String phone}) async {
    // ignore: missing_return
    switch (_provider) {
      case 'google':
        return await _loginRepository.signInWithGoogle();
        break;
      case 'facebook':
        return await _loginRepository.signInWithFacebook();
        break;
      case 'phone':
        return await _loginRepository.singInWithPhone(phone, context);
        break;
      case 'sign_out':
        await _loginRepository.singOut();
        break;
      default:
    }
  }

  Future<LocalUser> getCurrentUser() async {
    return await _loginRepository.getCurrentUser();
  }
}
