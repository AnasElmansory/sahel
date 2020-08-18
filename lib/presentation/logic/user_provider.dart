import 'package:flutter/cupertino.dart';
import 'package:sahel/domain/entities/local_user.dart';
import 'package:sahel/domain/usecases/user_authentication_usecase.dart';

class UserProvider extends ChangeNotifier {
  final UserAuthenticationUseCase _userAuthenticationUseCase;
  UserProvider(this._userAuthenticationUseCase);
  LocalUser _user;
  LocalUser get user => _user;
  set user(LocalUser newUser) {
    _user = newUser;
    notifyListeners();
  }

  void getCurrentUser() async =>
      user = await _userAuthenticationUseCase.getCurrentUser();
  Future<void> withGoogle() async =>
      user = await _userAuthenticationUseCase.call('google');
  Future<void> withFacebook() async =>
      user = await _userAuthenticationUseCase.call('facebook');
  Future<void> withPhone(String phone, context) async =>
      user = await _userAuthenticationUseCase.call('phone', phone: phone);
  Future<void> signOut() async {
    await _userAuthenticationUseCase.call('sign_out');
    user = null;
  }
}
